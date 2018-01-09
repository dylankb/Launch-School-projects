# Excercise 1
# Use the each method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value.
nums = (1..10).to_a
nums.each { |num| puts num }

# Excercise 2
# Same as above, but only print out values greater than 5.
nums.each do |num| 
  if num > 5
    puts num
  end
end 

# Excercise 3
# Using the same array from #2, use the select method to extract all odd numbers into a new array.
odd_nums = nums.select { |num| num.odd? }

# Excercise 4
# Append "11" to the end of the original array. Prepend "0" to the beginning.
nums.unshift(0)
nums.push(11)

# Excercise 5
# Get rid of "11". And append a "3".
nums.pop
nums << 3

# Excercise 6
# Get rid of duplicates without specifically removing any one value.
nums.uniq!

# Excercise 8
# Create a Hash using both Ruby syntax styles.
v_hash = {one: 1, two: 2, three: 3}
str_hash = {"one": 1, "two": 2, "three": 3}

# Excercise 9 
h = {a:1, b:2, c:3, d:4}
# 1. Get the value of key `:b`.
h[:b]
# 2. Add to this hash the key:value pair `{e:5}`
h[:e] = 5
# 3. Remove all key:value pairs whose value is less than 3.5 
h.delete_if { |key,value| value < 3.5 }

# Excercise 11

# I've enjoyed playing around with regular expressions before, so it was nice to Ruby's strong support of Regex. 

# Excercise 12

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

fields = [:email, :address, :phone]

# Push array into value slot - use the fact that key and array have same index. OR:
for i in (0..(contacts.length))
  contacts[contacts.keys[i]] = contact_data[i]
end

# Create new hashes inside hash for easy lookup. 
for i in (0..(contacts.length))
  contacts[contacts.keys[i]][:email] = contact_data[i][0]
  contacts[contacts.keys[i]][:address] = contact_data[i][1]
  contacts[contacts.keys[i]][:phone] = contact_data[i][2]
end

# Excercise 14
# Same solution using shift and do/each
contacts.each_with_index do |(key, value), index|
  fields.each do |field|
    value[field] = contact_data[index].shift
  end
end

# Excercise 15
# Delete words beginning with 's' or 'w'
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if { |e| e[0] == "s" || e[0] == "w" }

# Excercise 16 
# Turn existing array into a new array that consists of strings containing one word.
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

a.map! { |phrase| phrase.split() }
a.flatten!
  