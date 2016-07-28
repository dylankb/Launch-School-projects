# Ex. 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.has_key?("Spot")

# Ex 2. - Sum all ages
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
total_age = 0
ages.values.each { |age| total_age +=age }

# Ex 3. 
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.delete_if { |name, age| age > 100 }

# Ex 4. 

munsters_description = "The Munsters are creepy in a good way."
# 1.
munsters_description.capitalize!
# 2.
munsters_description.swapcase!
# 3. 
munsters_description.downcase!
#4. 
munsters_description.upcase!

# Ex. 5
# Combine the two arrays
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
additional_ages.merge!(ages)

# Ex. 6
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
ages.values.min

# Ex. 7
advice = "Few things in life are as important as house training your pet dinosaur."
advice.include?("Dino")

Ex. 8
# Find name that starts with "Be"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.select {  |name| name =~ /Be/ }

Ex. 9
# Change the length of all elements in an array
flintstones.map! do |name|
  name = name[0...3]

Ex. 10
# Complete the same task in one line
flintstones.map! { |name| name[0...3] }





