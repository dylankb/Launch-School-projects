number_string = File.read("number.rb").gsub!(/\n/, '')
p number_string.size

arr = []
number_string.chars.each_slice(3) do |slice|

  arr << slice.map(&:to_i).inject(&:+)
end

p arr
p arr.size
max = arr.index(arr.max)
p arr[205]

p number_string[max * 3,3]
