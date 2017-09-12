# def none?(collection)
#   collection.each { |ele| return false if yield(ele) }
#   true
# end

def any?(collection)
  collection.each { |ele| return true if yield(ele) }
  return false
end

def none?(collection, &block)
  !any?(collection, &block)
end

# var = none?([1, 3, 5, 6]) { |value| value.even? } == false
# p var
bar = none?([2, 4, 6, 8]) do |value|
  value.odd? == true
end
puts bar
puts none?([2, 4, 6, 8]) { |value| value.odd? }              # true
puts none?([2, 4, 6, 8]) { |value| value.odd? } == true      # true
puts none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false # true
puts none?([1, 3, 5, 7]) { |value| true } == false           # true
puts none?([1, 3, 5, 7]) { |value| false } == true           # true
puts none?([]) { |value| true } == true                      # true
