def count(arr)
  arr.inject(0) { |acc, ele| acc += 1 if yield(ele) }
  acc
end

puts count([1,2,3,4,5]) { |value| value.odd? } == 3
