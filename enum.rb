# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
	if block_given?
    	while i < size
      		yield(self[i])
      		i += 1
		end
    else
    	each do |x|
			p x
			i += 1
		end
	end
  end

  def my_each_with_index
    i = 0
	if block_given?
	    while i < size
			i += 1
	      	yield(self[i], i)
	    end
	else
		each do |x|
			p "index: #{i}, value: #{self[x]}"
			i += 1
		end
	end
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

  def my_all?(arg = nil)
    if block_given?
      my_each { |x| return false unless yield(x) }
    elsif arg.class == Class
      my_each { |x| return false unless x.class == arg }
    elsif arg.class == Regexp
      my_each { |x| return false if (x =~ arg).nil? }
    elsif arg.nil?
      my_each { |x| return false unless(x) }
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

  def my_none?(arg = nil)
	if block_given?
      	my_each { |x| return true unless yield(x) }
  	elsif arg.class == Class
      	my_each { |x| return true unless x.class == arg }
    elsif arg.class == Regexp
      	my_each { |x| return true if (x =~ arg).nil? }
    elsif arg.nil?
      	my_each { |x| return true unless(x) }
    end
    false
  end

  def my_count(arg = nil)
    i = 0
	if block_given?
    	i += 1 while i < size
	else
     my_each { |x| i += 1 }
 	end
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

  def my_inject(_param = self[0])
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

# TESTS
array = [4, 2, 1, 2, 1, 2, 7, 7, 7]
#p array.my_each_with_index
# p array.my_all? { |x| x < 8 }
# p array.my_any? { |x| x % 7 == 0 }
# p array.my_none? { |x| x > 3 }
ary = [1, 2, 4, 2]
ary.my_count               #=> 4
ary.my_count(2)            #=> 2
ary.my_count{ |x| x%2==0 } #=> 3
