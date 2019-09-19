module Enumerable

def my_each
  i = 0
  while i < self.size
	yield(self[i])
	i += 1
  end
  self
end

end

#EXAMPLES

#my_each
#["a", "b", "c"].my_each { |char| puts "#{char}" }
