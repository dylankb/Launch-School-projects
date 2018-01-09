# Make this work:

# class House
#   attr_reader :price
#
#   def initialize(price)
#     @price = price
#   end
# end

# puts "Home 1 is cheaper" if home1 < home2
# puts "Home 2 is more expensive" if home2 > home1

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < home2
# puts "Home 2 is more expensive" if home2 > home1

# No Comparable module solution
# class House
#   include Comparable
#   attr_reader :price
#
#   def initialize(price)
#     @price = price
#   end
#
#   def <(other)
#     if price < other.price
#       true
#     else
#       false
#     end
#   end
#
#   def >(other)
#     if price > other.price
#       true
#     else
#       false
#     end
#   end
# end

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < home2
# puts "Home 2 is more expensive" if home2 > home1

class House
  include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    self <=> other
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1.price < home2.price # makes comparison metric (price) explicit
puts "Home 2 is more expensive" if home2.price > home1.price
