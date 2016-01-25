def select(array)

  result = []
  counter = 0

  while counter < array.size
    current_element = array[counter]
    result << current_element if yield(current_element)

    counter += 1

  end
  result
end

array = [1,2,3]

p select(array) { |element| element.odd? }

# Yield calls .odd? on the current element
# When yield is called it's calling the block with a parameter. The parameterpassed in to the block is .odd?
