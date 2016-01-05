# class GoodDog
#   attr_accessor :name, :height, :weight

#   def initialize(n, h, w)
#     @name = n
#     @height = h
#     @weight = w
#   end

#   def speak
#     "#{name} says arf!"
#   end

#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end

#   def info
#     "#{self.name} weights #{self.weight} and is #{self.height} tall."
#   end

# end

# sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
# puts sparky.info

# sparky.change_info('Spartacus', '24 inches', '45 lbs')
# puts sparky.info

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(y, m, c)
    @year = y
    @model = m
    @car = c
    @speed = 0
  end

  def accelerate
    @speed += 20
  end

  def brake
    @speed -= 10
  end

  # def change_info(y, m, c)
  #   self.year = y
  #   self.model = m
  #   self.color = c
  # end

  # def info
  #   puts "My new car is a #{self.year} #{self.model} #{self.color}"
  # end

  def change_color(c)
    self.color = c
  end

end

big_red = MyCar.new('1998','Ford Ranger','Red')
#big_red.change_info('1997', 'Rord Banger', 'Pink')
big_red.change_color('green')
puts big_red.color

puts big_red.year
big_red.accelerate


