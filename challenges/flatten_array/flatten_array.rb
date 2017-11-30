def flatten(array, flattened_array = [])
  array.each do |element|
    if element.is_a?(Array)
      flatten(element, flattened_array)
    else
      flattened_array.push(element)
    end
  end

  flattened_array
end

puts flatten([1, [2], 3]) == [1, 2, 3]
puts flatten([[1, 2]]) == [1, 2] # true
puts flatten([[1, 2, 3, 4, 5]]) == [1, 2, 3, 4, 5] # true
puts flatten([[1, [2]]]) == [1, 2] # true
puts flatten([[1, [2, 3]]]) == [1, 2, 3] # true
puts flatten([[1, [2], [3, 4], [5]]]) == [1,2,3,4,5] # false
puts flatten([[[1, 2]]]) == [1, 2]

# Solution with reduce

# def flatten(array, empty_array = [])
#   array.reduce(empty_array) do |flat_array, element|
#     if element.is_a?(Array)
#       flatten(element, flat_array)
#     else
#       flat_array.push(element)
#     end
#   end
# end

# Initial attempt: Fails at "varying depths (structures which are deeper then shallower)"

# def flatten(nested_array)
#   flattened_array = []
#
#   current_array = nested_array
#   current_element = true # Improve this
#   while current_element != nil
#     current_element = current_array[0]
#     if current_element.kind_of?(Numeric)
#       flattened_array.push(current_array.shift)
#     else
#       current_array = current_array[0]
#     end
#   end
#
#   flattened_array
# end

# Previous attempt - recursion

# def flatten(array) # also fails at "undulating (deeper then shallower) depths"
#   flattened_array = []
#
#   retrieve_number(array, flattened_array)
#   return flattened_array
# end
#
# def retrieve_number(previous_element, flattened_array)
#   current_element = previous_element[0]
#   if current_element == nil
#     return flattened_array
#   elsif current_element.kind_of?(Numeric)
#     flattened_array.push(previous_element.shift)
#     future_element = previous_element
#   else
#     future_element = current_element
#   end
#
#   retrieve_number(future_element, flattened_array)
# end
