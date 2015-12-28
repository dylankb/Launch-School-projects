# Easy Questions: 1
# https://launchschool.com/lessons/263069da/assignments/3722

# # Excercises: Easy 1

# 1. 1,2,2,3

# 2
#  a. <some object>!=<some object> - asserts objects on either side of operator are not equal 
#  b. <some object>! - means that user_name evaluates to nil - !user_name
#  c. !<some object> - signifies that method is destructive (modifies the caller) - words.uniq!
#  d. ?<some object> - Turns the object name into a string. ?alpha => "alpha"
#  e. <some object>?- naming convention used to signify a method that returns a boolean value
#  f. !!<some object>> - used to turn any object into a boolean equivalent 
#  g. ?: - ternary operator for if...else


# 3.

# advice = "Few things in life are as important as house training your pet dinosaur."
# puts advice.gsub("important", "urgent")

# 4. 
# numbers = [1,2,3,4,5]
# numbers.delete_at(1)
# p numbers
# numbers.delete(1)
# p numbers
# numbers.delete(1)
# p numbers

# 5. 
# rng = (10..100)
# rng.include?(42)

# 6. famous_words = "seven years ago..."
# "Four score and" + famous words
# famous_words.prepend("Four score and")

# 8. ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]].flatten!

# 9,

# 10.
# flint_hsh = {}
# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# flintstones.each_with_index { | k, i | flint_hsh[k.to_sym] = i }
# p flint_hsh