# Ex. 1 -  Output of code below
numbers = [1, 2, 2, 3]
numbers.uniq
puts numbers
[1,2,2,3] because the array was not modified by the call to uniq (result would have been different with uniq!)

# Ex. 2
# The exclamation mark keyword (!) is often similar to the 'not' keyword:
# != - Use in an if/else flow to check whether a variable has a value equal to another variable, integer, string, etc.
# !var - if !username end then do x, is basically the equivalent of, if false then do x.
# !! (double bang) - turns a value into boolean value, but negates the negation of the single bang operator. Eg !!username == true
# However when used after certain methods '!' does not mean 'not'
# obj.uniq! marks the 'destructive' form of the uniq method
# A question mark is often used to denote that this method returns a boolean value because the method is calling 'istrueorfalse' on an object.
# For example, array.has_key? return a true of false value for whether a key is present in an array or not.
# ?a - character code for 'a'

# Ex. 3
# Replace the word "important" with "urgent" in the sentence
advice = "Few things in life are as important as house training your pet dinosaur."
advice.sub!("important","urgent")

# Ex 5. 
(10..100).cover?(42)

# Ex. 6

famous_words = "seven years ago..."
intro = "Four score"
famous_words_array = []
famous_words_array << famous_words
famous_words_array.unshift(intro).join(" ")

famous_words.prepend("Four score and ")

# Ex. 8
# Make the nested array a single array
chars = ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
chars.flatten!

# Ex. 9
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
flintstones.assoc("Barney")

# Ex. 10
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = {}

flintstones.each_with_index { |name, index| flintstones_hash[name] = index }





