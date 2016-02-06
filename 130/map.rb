# def map(arr, default=0)
#   count = 0
#   output = []

#   while count < arr.size
#     output << yield(arr[count])
#     count +=1
#   end
#   output
# end

# map([1,2,3]) do |num|
#   num.to_s + '!'
# end

output = [1,2,3].map do |num|
  if num == 3
    num = 'X'
  else
    num
  end
end
p output

output = [1,2,3].map do |num| 
  num < 3
end
p output

output = [1,2,3].map do |num|
  num < 3
  puts num
end
p output 