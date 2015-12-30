# 1. 
# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# flintstones << "Dino"

# 3.
# flintstones.push("Dino", "Hoppy")

# 4.
# advice = "Few things in life are as important as house training your pet dinosaur."
# advice.slice!(0, advice.index('house'))

# 5. 
# statement = "The Flintstones Rock!"
# statement.scan('t').count # alt. statement.count('t')

# 6.
# title = "Flintstone Family Members"
# puts title.center(40)

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  if dot_separated_words.size != 4
    return false
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break if !is_a_number?(word)
  end
  return true
end

puts dot_separated_ip_address(1.1.1.1)