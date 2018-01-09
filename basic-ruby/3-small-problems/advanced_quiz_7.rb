# 5.
# Generate a random 8 digit hexadecimal
def generate_uuid(sections=5)
  uuid = []
  charset = %w{0 1 2 3 4 6 7 9 A B C D E F G H J K L M N O P Q R S T U V W X Y Z}
  sections.times do
    uuid << charset.sample(8) + ["-"]
  end
  uuid.join.chop
end
puts generate_uuid()