munsters = { 
  "Herman" => { "age" => 32, "gender" => "male" }, 
  "Lily" => { "age" => 30, "gender" => "female" }, 
  "Grandpa" => { "age" => 402, "gender" => "male" }, 
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |person, _|
  case munsters[person]['age']
  when 0..17
    munsters[person]['age_group'] = 'kid'
  when 18..64
    munsters[person]['age_group'] = 'adult'
  else
    munsters[person]['age_group'] = 'senior'
  end
end

p munsters

# 1. 
# str = 'The Flintstones Rock!'
# space = ""

# 10.times { |times| puts (" " * times) + str }

# 2. 

# result = {}
# alphabet = ('A'..'Z').to_a + ('a'..'z').to_a
# alphabet.each do |letter|
#   letter_count = str.scan(letter).count
#   result[letter] = letter_count if letter_count > 0
# end

# 3. 
# puts "the value of 40 + 2 is " + (40 + 2)
# You cannot concattenate a string and a Fixnum

# puts "the value of 40 + 2 is " + (40 + 2).to_s
# puts "the value of 40 + 2 is #{40 + 2}"

# 4. 
# Add an early return statement to protect against zero
# def factors(number)
#   if number == 0
#     return 0
#   else
#     dividend = number
#     divisors = []
#     begin
#       divisors << number / dividend if number % dividend == 0
#       dividend -= 1
#     end until dividend == 0
#     divisors
#   end
# end

# Use a while condition for the loop:

# while dividend > 0 do
#   divisors << number / dividend if number % dividend == 0
#   dividend -= 1
# end

# 7.
# limit = 15

# def fib(first_num, second_num, limit)
#   while second_num < limit
#     sum = first_num + second_num
#     first_num = second_num
#     second_num = sum
#   end
#   sum
# end

# result = fib(0, 1, limit)
# puts "result is #{result}"

# 8.

# def titelize(str)
#   str.split.map { |word| word.downcase.capitalize }.join(' ')
# end

# 9. 







