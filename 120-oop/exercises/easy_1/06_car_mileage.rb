# class Car
#   attr_accessor :mileage
#
#   def initialize
#     @mileage = 0
#   end
#
#   def increment_mileage(miles)
#     total = mileage + miles
#     mileage = total
#   end
#
#   def print_mileage
#     puts mileage
#   end
# end

# Add self. in setter to avoid just creating a local instance variable

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total # Could use @mileage=, but that would bypass any setter logic.
  end

  def print_mileage
    puts mileage
  end
end

# car = Car.new
# car.mileage = 5000
# car.increment_mileage(678)
# car.print_mileage  # 5000 (should print 5678)
