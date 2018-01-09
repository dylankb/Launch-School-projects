module Rootable
  def root_mode
    puts "You can take your truck rooting!"
  end
end

class Vehicle
  attr_accessor :color, :model, :year, :speed
  @@number_of_vehicles = 0

  def initialize(y, m, c, s=0)
    self.year = y
    self.model = m
    self.color = c
    self.speed = s
    @@number_of_vehicles += 1
  end

  def accelerate(number)
    self.speed += number
    puts "You accelerate #{number} mph"
  end

  def brake(number)
    self.speed -= number
    puts "You accelerate #{number} mph"    
  end

  def current_speed
    puts "Your speed is #{self.speed}"
  end

  def change_color(c)
    self.color = c
  end

  def to_s
    "A #{self.color} #{self.year} #{self.model}."
  end

  def self.gas_mileage(miles, gallons)
    puts "The #{self.model}'s gas mileage is #{miles/gallons}"
  end

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  def print_age
    puts "This vehicle is #{age} years old"
  end

  private

  def age
    Time.now.year - self.year.to_i
  end

end 

class MyCar < Vehicle
  BACK = 'Trunk'
end

class MyTruck < Vehicle
  include Rootable

  BACK = 'Bed'
end

big_red = MyTruck.new('1998','Ford Ranger','Red')
puts Vehicle.number_of_vehicles
puts big_red.root_mode
big_red.print_age

print MyTruck.ancestors


class Student

  def initialize(name, grade)
    name = name
    grade = grade
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected

  def grade
    @grade
  end
 end

bob = Student.new('Bob', 90)
tom = Student.new('Tom', 80)
puts 'Well done!' if bob.better_grade_than?(tom)
