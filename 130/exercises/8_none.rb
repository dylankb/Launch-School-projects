# def none?(collection)
#   collection.each { |ele| return false if yield(ele) }
#   true
# end

def any?(collection)
  collection.each { |ele| return false unless yield(ele) }
  true
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
none?([2, 4, 6, 8]) { |value| value.odd? } == true
none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
none?([1, 3, 5, 7]) { |value| true } == false
none?([1, 3, 5, 7]) { |value| false } == true
none?([]) { |value| true } == true
