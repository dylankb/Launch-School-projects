require 'pry'

number_string = File.read("number.rb").gsub!(/\n/, '')
numbers_array = number_string.chars.map(&:to_i)

greatest = []

number_string.size.times do |i|
  arr = []
  numbers_array[i..-1].each_slice(4) do |slice|
    arr << slice.inject(&:*)
  end
  greatest_index = arr.index(arr.max)
  greatest << numbers_array[(greatest_index * 4)+i,4] 
end

#p greatest

sums = greatest.map do |range|
  range.inject(:*)
end

#p sums

max = sums.max
max_index = sums.index(max)

#binding.pry
#p max_index

p greatest[max_index]


# p arr
# p arr.size

# p arr[205]

p 
