# 1. 
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
# ages.include?('Spot')

# 2. 
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
# puts ages.values.inject(:+)

# 3. 
# ages.keep_if { |name, age| age < 100 } # destructive

# 4.
# munsters_description = "The Munsters are creepy in a good way."
  
# munsters_description.downcase.capitalize!
# munsters_description.swapcase!
# munsters_description.downcase!
# munsters_description.upcase!

# 5. 
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
# additional_ages = { "Marilyn" => 22, "Spot" => 237 }
# ages.merge!(additional_ages)
# p ages

# 6. 
# ages.values.min

# 7.
# advice.match("Dino") # alt. advice.include?("Dino")

# 8.
# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# flintstones.index { |name| name[0..1] == ("Be") }

#9. 

# flintstones.map! { |name| name[0,3]}
# puts flintstones
