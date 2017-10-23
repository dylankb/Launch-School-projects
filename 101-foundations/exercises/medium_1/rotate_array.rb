# Original
# def rotate_array(array)
#   array_clone = array.dup
#   array_clone[array_clone.length - 1] = array_clone.shift
#   return array_clone
# end

# Solution
def rotate_array(array)
  array[1..-1] + [array[0]]
end
#p rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]

# def rotate_string(string)
#   string.split('')[1..-1] + [string[0]]
# end

def rotate_string(string)
  rotate_array(string.split('')).join('')
end
# p rotate_string('abc') == 'bca'

def rotate_number(number)
  rotate_array(number.to_s.split('')).join('').to_i
end
p rotate_number(123) == 231
