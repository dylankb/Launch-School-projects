class Car
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def Car.another_class_method
    puts "Another class method"
  end
end

bob = Car.new('bob')

puts bob.another_class_method



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
#     @name = n
#     @height = h
#     @weight = w
#   end

#   def info
#     "#{name} weighs #{weight} and is #{height} tall."
#   end
# end

# sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
# puts sparky.info

# sparky.change_info('Spartacus', '24 inches', '45 lbs')

# puts sparky.info

# class KrispyKreme
#   attr_reader :filling, :toping

#   def initialize(filling, toping)
#     @filling = filling
#     @toping = toping
#   end

#   def to_s
#     # if !filling && toping
#     #   "Plain with #{toping}"
#     # elsif !filling && !toping
#     #   "Plain"
#     # elsif filling && !toping
#     #   "#{filling}"
#     # else
#     #   "#{filling} with #{toping}"
#     # end
#     filling_string = !filling ? 'Plain' : filling
#     toping_string = !toping ? '' : ' with ' + toping
#     filling_string + toping_string
#   end
# end

# donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
# donut5 = KrispyKreme.new("Custard", "icing")

# puts donut1
# #  => "Plain"
# puts donut2
# #  => "Vanilla"
# puts donut3
# #  => "Plain with sugar"
# puts donut4
# #  => "Plain with chocolate sprinkles"
# puts donut5
# #  => "Custard with icing"