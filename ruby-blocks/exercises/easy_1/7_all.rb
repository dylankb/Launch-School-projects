# def all?(collection)
#   collection.each do |ele|
#     unless yield(ele)
#       return false
#     end
#   end
#   return true
# end

def all?(collection)
  collection.each { |ele| return false unless yield(ele) }
  true
end

test = all?([2,4,6]) { |value| value.even? } == true
p test
