# frozen_string_literal: true

require './lib/enum.rb'

RSpec.describe Enumerable do
	let(:animals) { %w[cat mouse dog jiraffe monkey squirrel] }
	let(:numbers) { [1, 2, 5, 3, 8, 9] }
	let(:collection_true) { ["hello", true, 65, [], {}] }
	let(:collection_false) { [nil, false] }
	let(:collection_mixed) { [0, 1, false, true, "world", nil, []] }
	let(:lessThanTen) { proc { |x| x < 10 } }
	let(:greaterThanTen) { proc { |x| x > 10 } }
	let(:isString) { proc { |x| x.class == String } }
	let(:isInt) { proc { |x| x.class == Integer } }
	let(:timesTwo) { proc {|x| x * 2 } }
	let(:sum) { proc {|x, y| x + y } }

  describe '#my_each' do
    it 'Returns enumerator if block_given? is false' do
			array = [1, 2, 3]
      expect(array.my_each).to be_an(Enumerator)
		end

		it 'Returns each element of self when a block is passed' do
			my_each_array = []
      each_array = []
      animals.my_each { |element| my_each_array << element }
      animals.each { |element| each_array << element }
			expect(my_each_array).to eql(each_array)
		end
  end

	describe '#my_each_with_index' do
    it 'Returns enumerator if block_given? is false' do
			array = [1, 2, 3]
      expect(array.my_each_with_index).to be_an(Enumerator)
		end

		it 'Returns each element with their respective index when a block is passed' do
			my_each_with_index_array = []
      each_with_index_array = []
      numbers.my_each { |element, index| my_each_with_index_array << index }
      numbers.each { |element, index| each_with_index_array << index }
			expect(my_each_with_index_array).to eql(each_with_index_array)
		end
	end

	describe '#my_select' do
		it 'Returns array with all elements for which the given block returns true' do
			expect(numbers.my_select { |n| n > 3 }).to eql([5, 8, 9])
		end

		it 'Returns enumerator if no block is given' do
			array = [1, 2, 3]
      expect(array.my_select).to be_an(Enumerator)
		end
	end

	describe '#my_all?' do
		it 'Returns true if the block passed never returns false/nil' do
			expect(numbers.my_all?(&lessThanTen)).to eql(true)
			expect(numbers.my_all?(&greaterThanTen)).to eql(false)
		end

		context 'Argument = Collection'
		it 'Returns true when all elements of a collection are != false/nil' do
			expect(collection_true.my_all?).to eql(true)
			expect(collection_false.my_all?).to eql(false)
		end

		context 'Argument = Class'
		it 'Returns true when all elements belong to the class passed as argument' do
			expect(numbers.my_all?(Integer)).to eql(true)
			expect(numbers.my_all?(String)).to eql(false)
		end

		context 'Argument = Regexp'
		it 'Returns true when all elements match the Regular Expression passed' do
			expect(animals.my_all?(/[a-z]/)).to eql(true)
			expect(animals.my_all?(/d/)).to eql(false)
		end
	end

	describe '#my_any?' do
		it 'Returns true if the block passed ever returns a value other than true' do
			expect(collection_mixed.my_any?(String)).to eql(true)
			expect(numbers.my_any?(&isString)).to eql(false)
		end

		context 'Argument = Collection'
		it 'Returns true if any element of a collection is != false/nil' do
			expect(collection_true.my_any?).to eql(true)
			expect(collection_false.my_any?).to eql(false)
		end

		context 'Argument = Class'
		it 'Returns true if any element belongs to the class passed ar argument' do
			expect(collection_mixed.my_any?(String)).to eql(true)
			expect(animals.my_any?(Integer)).to eql(false)
		end

		context 'Argument = Regexp'
		it 'Returns true if any element belongs to the Regular Expression passed ar argument' do
			expect(collection_mixed.my_any?(/d/)).to eql(true)
			expect(numbers.my_any?(/w/)).to eql(false)
		end
	end

	describe '#my_none?' do
		it 'Returns true if the block passed ever returns a value other than false' do
			expect(collection_mixed.my_none?(String)).to eql(false)
			expect(numbers.my_none?(&isString)).to eql(true)
		end

		context 'Argument = Collection'
		it 'Returns true if any element of a collection is != true' do
			expect(collection_true.my_none?).to eql(false)
			expect(collection_false.my_none?).to eql(true)
		end

		context 'Argument = Class'
		it 'Returns true if no element belongs to the class passed ar argument' do
			expect(collection_mixed.my_none?(String)).to eql(false)
			expect(animals.my_none?(Integer)).to eql(true)
		end

		context 'Argument = Regexp'
		it 'Returns true if no element belongs to the Regular Expression passed ar argument' do
			expect(collection_mixed.my_none?(/d/)).to eql(false)
			expect(numbers.my_none?(/w/)).to eql(true)
		end
	end

	describe '#my_count' do
		it 'Returns the number of elements whose condition evaluates to true' do
			expect(animals.my_count).to eql(6)
		end

		context 'Block is passed'
		it 'Returns the number of elements yielding a true value' do
			expect(numbers.my_count(&lessThanTen)).to eql(6)
		end
	end

	describe '#my_map' do
		it 'Returns enumerator if no block is given' do
      expect(numbers.my_map).to be_an(Enumerator)
		end

		it 'Returns new array after running the block passed for every element' do
			expect(numbers.my_map(&timesTwo)).to eql([2, 4, 10, 6, 16, 18])
		end
	end

	describe '#my_inject' do
		context 'Block is passed as argument'
		it 'Returns an accumulator by combining all elements and passing a block(operator)' do
			expect(numbers.my_inject(&sum)).to eql(28)
		end

		context 'Symbol is passed as argument'
		it 'Returns an accumulator by combining all elements and passing a symbol(operator)' do
			expect(numbers.my_inject(:+)).to eql(28)
		end
	end

end
