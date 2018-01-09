# first attempt
# def create_digit_groups(number)
#   digits = number.to_s.split('')
#   iterations = digits.size / 2
#   digit_groups = [[], []]
#   counter = 0
#   2.times do |outer_iteration|
#     iterations.times do |_|
#       digit_groups[outer_iteration] << digits[counter]
#       counter += 1
#     end
#
#     digit_groups[outer_iteration].join.to_i
#   end
#
#   digit_groups
# end

# scan / regex solution
# def create_digit_groups(number)
#   number_string = number.to_s
#   grouping_size = number_string.size / 2
#   regex_string = ".{#{grouping_size}}"
#   digit_groups = number_string.scan(Regexp.new(regex_string))
# end

# enumerator / map solution
def create_digit_groups(number)
  number_string = number.to_s
  grouping_size = number_string.size / 2
  number_string.chars.each_slice(grouping_size).map(&:join)
end

def even_digits_length?(number)
  digits = number.to_s.split('')
  digits.size.even?
end

def double?(number)
  if even_digits_length?(number)
    left_group, right_group = create_digit_groups(number)

    return if left_group == right_group
    return number * 2
  end
end

puts double?(344344)
# nil
puts double?(3435)
# 6870
