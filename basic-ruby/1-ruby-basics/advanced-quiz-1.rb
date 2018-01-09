# Ex. 4
# Generate a random 8 digit hexadecimal
def generate_uuid(sections=5)
  uuid = []
  charset = %w{0 1 2 3 4 6 7 9 A C D E F G H J K M N O P Q R T V W X Y Z}
  sections.times do
    uuid << charset.sample(8).join + "-"
  end
  uuid.join.chop
end
puts generate_uuid()

# Ex 5.
# Validate if is a string is a valid IP address

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  if dot_separated_words[0].length != 2 || dot_separated_words[3].length != 2 || dot_separated_words.length != 4
    return false
  end
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless !is_a_number?(word)
  end
  return true
end

puts dot_separated_ip_address?("1.1.2.11")
