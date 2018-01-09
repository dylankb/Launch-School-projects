class MyCar
  attr_accessor :color, :model, :year, :speed

  def initialize(y, m, c, s=0)
    self.year = y
    self.model = m
    self.color = c
    self.speed = s
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

  def gas_mileage(miles, gallons)
    puts "The #{self.model}'s gas mileage is #{miles/gallons}"
  end
end

big_red = MyCar.new('1998','Ford Ranger','Red')
big_red.gas_mileage(410,21)
big_red.accelerate(20)
big_red.current_speed
puts big_red
