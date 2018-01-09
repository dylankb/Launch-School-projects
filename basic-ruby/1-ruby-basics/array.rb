#Excercise 1
def find_arr(num)
  arr = [1, 2, 4, 5, 6]
  arr.include?(num)
end
puts find_arr(3)

#Excercise 2
# 1.
001 => ['b','a']
arr ==['b','a']
002 => [["b", 1], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]
arr = [["b", 1], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]
003 => 1
arr = [["b"], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]

# 2.
001 => ['b','a']
arr ==['b','a']
002 => ["b", [1,2,3],["a",[1,2,3]]]
arr == ["b", [1,2,3],["a",[1,2,3]]]
003 => [1,2,3]
arr == ["b", ,["a",[1,2,3]]]

# Excercise 3
arr = [["test", "hello", "world"],["example", "mem"]]
puts arr.last.first
puts arr[1][0]

# Excercise 4
# 1. 3
# 2. 3
# 3. 5

# Excercise 5
# 1. "e"
# 2. "T"
# 3. "A"

# Excercise 6
names[3] = 'jody'

# Excercise 7
nums = (1..10).to_a
new_nums = []
nums.each do |num| 
  num += 2
  new_nums.push(num)
end




