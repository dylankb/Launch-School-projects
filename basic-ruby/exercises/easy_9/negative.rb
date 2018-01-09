def negative(number)
  number > 0 ? -number : number
end

puts negative(5) == -5
puts negative(-3) == -3
puts negative(0) == 0
