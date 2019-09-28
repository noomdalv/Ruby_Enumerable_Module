# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    if block_given?
      while i < size
        yield(self[i])
        i += 1
      end
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    if block_given?
      while i < size
        yield(self[i], i)
        i += 1
      end
    end
  end

  def my_select
    return to_enum unless block_given?

    i = 0
    new_array = []
    while i < size
      new_array << self[i] if yield(self[i]) == true
      i += 1
    end
    new_array
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |x| return false unless yield(x) }
    elsif arg.class == Class
      my_each { |x| return false unless x.class == arg }
    elsif arg.class == Regexp
      my_each { |x| return false if (x =~ arg).nil? }
    elsif !arg.nil?
      my_each { |x| return false unless x == arg }
    elsif arg.nil?
      my_each { |x| return false unless x }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |x| return true if yield(x) }
    elsif arg.class == Class
      my_each { |x| return true if x.class == arg }
    elsif arg.class == Regexp
      my_each { |x| return true if x =~ arg }
    elsif arg.nil?
      my_each { |x| return true if x }
    else
      my_each { |x| return true if x == arg }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given?
      my_each { |x| return false if yield(x) }
    elsif arg.class == Class
      my_each { |x| return false if x.class == arg }
    elsif arg.class == Regexp
      my_each { |x| return false if x =~ arg }
    elsif arg.nil?
      my_each { |x| return false if x }
    else
      my_each { |x| return false if x == arg }
    end
    true
  end

  def my_count(arg = nil)
    i = 0
    if block_given?
      my_each { |x| i += 1 if yield(x) }
    elsif arg.nil?
      my_each { |_x| i += 1 }
    elsif !arg.nil?
      my_each { |x| i += 1 if arg == x }
    end
    i
  end

  def my_map
    return to_enum unless block_given?

    array = []
    i = 0
    while i < size
      array << yield(self[i])
      i += 1
    end
    array
  end

  def my_inject(accumulator = nil, symbol = nil)
    if !accumulator.nil? && !symbol.nil?
      my_each { |num| accumulator = accumulator.method(symbol).call(num) }
      accumulator
    elsif !accumulator.nil? && accumulator.is_a?(Symbol) && symbol.nil?
      memo, *remaining_elements = self
      remaining_elements.my_each { |num| memo = memo.method(accumulator).call(num) }
      memo
    elsif !accumulator.nil? && accumulator.is_a?(Integer) && symbol.nil?
      array = to_a
      array.my_each { |num| accumulator = yield(accumulator, num) }
      accumulator
    elsif accumulator.nil? && symbol.nil?
      array = to_a
      accumulator = array.shift
      array.my_each do |num|
        accumulator = yield(accumulator, num)
      end
    end
    accumulator
  end
end

def multiply_els(array)
  array.my_inject { |product, value| p product * value }
end
