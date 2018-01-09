#Excercise 1
[1,2,3,4,5] 

# #Excercise 2
puts "What do you want to do? "
response = gets.chomp
while response != 'STOP'
  puts "What do you want to do? "
  response = gets.chomp
  if response == 'STOP'
    break
  end
end

#Excercise 3
names = {}
%w(John, Jacob, Jingleheimer, Schmidt).each_with_index { |name, index| names[name] = index }
puts names

#Excercise 4
def final_countdown(num)
  puts num
  if num > 0
    final_countdown(num -1)
  end
end

final_countdown(10)