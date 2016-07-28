# Basics Chapter
# Excercise 1
first_name = "Dylan"
last_name = "Barnard"
puts first_name + " " + last_name

# Excercise 2
thousands = 1234 / 1000
hundreds = (1234 / 100 % 10)
tens = (1234 / 10 % 10)
ones = 1234 % 10

# Excercise 3
movie_years =  {"North By Northwest" => 1942, "Gladiator" => 2000, "Prometheus"=> 2012}
puts movie_years["North By Northwest"]
puts movie_years["Gladiator"]
puts movie_years["Prometheus"]

# Excercise 4
movie_array = [movie_years["North By Northwest"], movie_years["Gladiator"], movie_years["Prometheus"]]
movie_array[0]
movie_array[1]
movie_array[2]

# Excercise 5
def factorial(n)
  if n == 1
    return 1
  else
    n * factorial(n-1)
  end 
end 
puts factorial(5)
puts factorial(6)
puts factorial(7)
puts factorial(8)

#Excercise 6
puts "Enter number 1"
num1 = gets.chomp.to_f
puts num1 * num1
puts "Enter number 2"
num2 = gets.chomp.to_f
puts num2 * num2
puts "Enter number 3"
num3 = gets.chomp.to_f
puts num3 * num3


