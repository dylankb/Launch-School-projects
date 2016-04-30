require 'pry'

number_string = File.read("number.rb").gsub!(/\n/, '')
numbers_array = number_string.chars.map(&:to_i)

def find_greatest_values(numbers_array)
  numbers_array.size.times.with_object([]) do |i, large_slices|
    arr = []
    numbers_array[i..-1].each_slice(4) do |slice|
      arr << slice.inject(&:*) 
    end
    large_value_index = arr.index(arr.max)
    large_slices << numbers_array[(large_value_index * 4)+i,4] 
  end
end

greatest_slices = find_greatest_values(numbers_array)
p greatest_slices

def find_greatest_slice(greatest_slices)
  sums = greatest_slices.map { |range| range.inject(:*) }
  max_index = sums.index(sums.max)
  greatest_slices[max_index]
end

p find_greatest_slice(greatest_slices)

# def find_product_per_slice(numbers_array)
#   numbers_array.size.times.with_object([]) do |i, slices|
#     numbers_array[i..-1].each_slice(4) do |slice|
#       slices << slice.inject(&:*) 
#     end
#     slices
#   end
# end

# slice_products = find_product_per_slice(numbers_array)

# p slice_products

# def find_largest_product_per_slice(slice_products)
#   slice_products.inject([]) do |product,|
#   end
# end


# p arr
# p arr.size

# p arr[205]
