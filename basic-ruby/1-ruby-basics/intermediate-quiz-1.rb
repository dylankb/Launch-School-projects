# Ex. 1
# Indent one space more every time 10 times
statement = "The Flintstones Rock!"
for i in (0..9)
  puts statement.rjust(statement.length + i)
end

# Ex. 2
statement = "The Flintstones Rock!"
split_statement = statement.split("")
frequency = {}
split_statement.each do |letter| 
  frequency[letter] = split_statement.count(letter) if split_statement.count(letter) > 0
end

# Ex. 3
# 1.
puts "the value of 40 + 2 is " + (40 + 2).to_s

# 2. 
a = 40
puts "the value of 40 + 2 is #{40 + 2}"

# Ex. 5
# Using error handling to make 0 value work
def factors(number)
  dividend = number
  divisors = []
begin
  begin
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end until dividend == 0
    divisors
  end
rescue
  puts "No dividends!"
end

# Use a while loop instead
def factors(number)
  dividend = number
  divisors = []
  while divident > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
end

# Ex. 9

string = ("this should be titelized")
new_string = string.split
title = new_string.each { |word| word.capitalize! }
new_title = title.join(" ")

string.split.map { |word| word.downcase.capitalize!}.join(' ')

# Ex. 10