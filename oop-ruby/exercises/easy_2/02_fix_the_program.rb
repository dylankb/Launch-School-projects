# module Drivable   # Broken version
#   def self.drive  # Don't define modue methods with self (only accessible via Drivable.drive)
#   end
# end

module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
