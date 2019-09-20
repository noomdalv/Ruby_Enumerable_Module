# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
    end

  def my_select
    i = 0
    new_array = []
    while i < size
      new_array << self[i] if yield(self[i]) == true
      i += 1
    end
    new_array
  end

  def my_all?
    i = 0
    while i < size
      return false if yield(self[i]) == false || yield(self[i]).nil?

      i += 1
    end
    true
  end

  def my_any?
    i = 0
    while i < size
      return true if yield(self[i])

      i += 1
    end
    false
  end

  def my_none?
    i = 0
    while i < size
      return false if yield(self[i])

      i += 1
    end
    true
  end

  def my_count
    i = 0
    i += 1 if yield(self[i]) while i < size
    i
    end

  def my_map
    array = []
    i = 0
    while i < size
      array << yield(self[i])
      i += 1
    end
    array
  end

  def my_map_block(&block)
    array = []
    i = 0
    while i < size
      array << block.call(self[i])
      i += 1
    end
    array
  end

  def my_map_proc_block(arg = nil)
    array = []
    i = 0
    while i < size
      if arg.nil? && block_given?
        array << yield(self[i])
      elsif !arg.nil? && block_given?
        array << arg.call(self[i])
      end
      i += 1
    end
    array
  end

  def my_inject(x = self[0])
    total = 1
    if self.class == Array
      my_each do |value|
        total = yield(total, value)
      end

    elsif self.class == Hash
      my_each do |_key, value|
        total = yield(total, value)
      end
    end
    total
  end
end

def multiply_els(array)
  array.my_inject { |product, value| p product * value }
end

# test
multiply_els([2, 4, 5])
