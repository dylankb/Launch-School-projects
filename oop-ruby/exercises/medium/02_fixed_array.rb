class FixedArray < Array

  def initialize(size)
    @size = size
    @array = Array.new(size)
  end

  def [](index)
    @array.fetch(index) # allows you to raise IndexError if no index
  end

  def to_a
    @array.clone
  end

  def to_s
    to_a.to_s
  end

  def []=(index, value)
    @array.fetch(index)
    @array[index] = value
  end
end

fixed_array = FixedArray.new(5)

puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'

puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end
#
begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

fa = FixedArray.new(50)
a = fa.to_a
a.delete_at(0)
p a.length
