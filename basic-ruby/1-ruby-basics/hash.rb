# Excercise 1

family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
        }
  
immediate_family = family.select { |k,v| k == :sisters || k == :brothers}
arr = immediate_family.values.flatten
p arr

# Excercise 2

arr1 = {one: "uno", two: "dos", three: "tres"}
arr2 = {one: "yi", two: "er", three: "san", four:"si"}

p arr2.merge(arr1)
p arr2
p arr1

arr1 = {one: "uno", two: "dos", three: "tres"}
arr2 = {one: "yi", two: "er", three: "san", four:"si"}

p arr2.merge!(arr1)
p arr2
p arr1

# Excercise 3

arr = (('a'..'z').to_a).zip((1..26).to_a).to_h
p arr.keys
p arr.values
arr.each do |k,v|
  puts "Key: #{k} | Value: #{v}"
end

# Excercise 4
person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}
puts person[:name]

# Excercise 5
arr1 = {:one => rand(9), :two=>rand(9)}
arr1.has_value?(7)
p arr1.has_value?(7)

# not sure how to get this to display bool when running rb file

# Excercise 6
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

arr = {}
alpha_words = []
words.each do |word|
  key = word.split('').sort.join
  if arr.has_key?(key)
    arr[key].push(word)
  else
    arr[key] = [word]
  end
end
p arr
  

