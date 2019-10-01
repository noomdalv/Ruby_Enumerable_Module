# frozen_string_literal: true

require './lib/enum.rb'

RSpec.describe Enumerable do
	let(:enum) { Enumerable.new }
	let(:animals) { %w[cat mouse dog jiraffe monkey squirrel] }
	let(:numbers) { [1, 3, 5, 8, 9] }

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

end
