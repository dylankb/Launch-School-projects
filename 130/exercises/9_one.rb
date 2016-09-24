def one?(collection)
  count = 0
  collection.inject(0) do |acc, ele|
    count += 1 if yield(ele)
    return false if count > 1
  end
  return true if count == 1
  false
end

# Solution
# def one?(collection)
#   seen_one = false
#   collection.each do |element|
#     next unless yield(element)
#     return false if seen_one
#     seen_one = true
#   end
#   seen_one
# end

bar = one?([2, 5, 6, 8]) do |value|
  value.odd? == true
end

puts bar
