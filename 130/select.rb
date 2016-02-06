## My Implementation ##

# def select(arr)
#   counter = 0
#   output = []

#   while counter < arr.size
#     if yield(arr[counter])
#       output << arr[counter]
#     end
#     counter += 1
#   end
#   output
# end

## Solution ###

# def select(array)

#   result = []
#   counter = 0

#   while counter < array.size
#     current_element = array[counter]
#     result << current_element if yield(current_element)

#     counter += 1

#   end
#   result
# end

result = [1,2,3].select do |num|
  true
end
p result

result = [1,2,3].select do |num|
  0
end
puts "-- 2 --"
p result

result = [1,2,3].select do |num|
  num > 2
  puts true
end
p result

result = [1,2,3].select
p result
