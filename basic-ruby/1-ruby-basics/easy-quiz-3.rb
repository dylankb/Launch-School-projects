# Ex. 1 - Easier way to write an array
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Ex. 2 - Add "Dino" to array
flintstones << "Dino"

# Ex. 3 
flintstones.push("Dino", "Hoppy")

# Ex. 4
advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice!(0, advice.index('house')

# Ex. 5 - Number of lower case 't's
statement = "The Flintstones Rock!"
statement.scan("t").length # .count also works

# Ex. 6
title = "Flintstone Family Members"
title.center(40)