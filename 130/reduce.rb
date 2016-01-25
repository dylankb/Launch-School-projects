def reduce(array, ival=0)

  counter = 0
  sum = ival

  while counter < array.size
    current_element = array[counter]
    sum = yield(sum, current_element)

    counter += 1 
  end

  sum
end


array = [1, 2, 3, 4, 5]

puts reduce(array, 10) { |acc, num| acc + num }  