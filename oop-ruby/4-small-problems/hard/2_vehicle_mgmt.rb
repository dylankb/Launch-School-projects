# Provided solution - uses write access to fuel_capacity, fuel_efficiency

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
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
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
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Moveable

  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end
end

# My solution - Not as good. Modules should encapsulate (related) functionality. I think initialze would be better suited to a super class.

# module Moveable
#   attr_accessor :speed, :heading
#
#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     @fuel_efficiency = km_traveled_per_liter
#     @fuel_capacity = liters_of_fuel_capacity
#   end
#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end
#
# class WheeledVehicle
#   include Moveable
#
#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     @tires = tire_array
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#   end
#
#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end
#
#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end
#
# class Auto < WheeledVehicle
#   def initialize
#     # 4 tires are various tire pressures
#     super([30,30,32,32], 50, 25.0)
#   end
# end
#
# class Motorcycle < WheeledVehicle
#   def initialize
#     # 2 tires are various tire pressures
#     super([20,20], 80, 8.0)
#   end
# end
#
# class Catamaran
#   include Moveable
#   attr_accessor :propeller_count, :hull_count
#
#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     @hull_count = num_hulls
#     @propeller_count = num_propellers
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

auto = Auto.new
puts auto.range

cata = Catamaran.new(2,2,100,50)
puts cata.range
