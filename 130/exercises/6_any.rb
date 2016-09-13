def any?(arr)
  # i = 0
  # while arr.length > i
  #   if yield arr[i]
  #     return true
  #   end
  #   i += 1
  arr.each { |ele | return true if yield(ele) }
  false
end

bar = any?({a: 1}) {|value| puts value } == true
p bar
# var = any?([1, 3, 5, 6]) do |value|
#   value.even?
# end
# p var
# any?([1, 3, 5, 7]) { |value| value.even? } == false
# any?([2, 4, 6, 8]) { |value| value.odd? } == false
# any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
# any?([1, 3, 5, 7]) { |value| true } == true
# any?([1, 3, 5, 7]) { |value| false } == false
# any?([]) { |value| true } == false
