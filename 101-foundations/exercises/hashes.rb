car = { type: "sedan",	color: "blue", mileage:	80_000 }
car[:year] = 1998

numbers = {
  high:   100,
  medium: 50,
  low:    10
}

numbers.keys.each do |key, value|
  puts "The #{key} number is #{value}" # or #{numbers[key]}
end

half_numbers = numbers.map { |key, value| value / 2 }
p half_numbers
