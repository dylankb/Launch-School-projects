# Medium Quiz Pt. 1

# 5. My solution

# class KrispyKreme
#   attr_reader :glazing
#   attr_accessor :filling_type
#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#     set_default_filling
#   end

#   def set_default_filling
#     if !filling_type
#       @filling_type = 'plain'
#     end
#   end

#   def to_s
#     if !glazing
#       "#{filling_type}"
#     else
#       "#{filling_type} with #{glazing}"
#     end
#   end
# end

# #5 - Official Solution

# # class KrispyKreme
# #   attr_reader :glazing
# #   attr_accessor :filling_type
  
# #   def initialize(filling_type, glazing)
# #     @filling_type = filling_type
# #     @glazing = glazing
# #   end

# #   def to_s
# #     filling_string = filling_type ? filling_type : "Plain"
# #     glazing_string = glazing ? " with #{glazing}" : ''
# #     filling_string + glazing_string
# #   end
# # end

# donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
# donut5 = KrispyKreme.new("Custard", "icing")

# puts donut1
# puts donut2
# puts donut3
# puts donut4
# puts donut5

# Hard Quiz

require 'pry'

module Moveable
  attr_accessor :speed, :heading 
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures along with
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Moveable
  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
end

endeavour = Catamaran.new(4,2,100,10)
puts endeavour.range
puts endeavour.propeller_count