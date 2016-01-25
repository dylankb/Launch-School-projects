require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require 'pry'

require_relative 'car'

# class CarTest < MiniTest::Test
  
#   #assert(test)
#   #Fails unless test is truthy.

#   def setup
#     @car = Car.new
#   end

#   def test_car_exists
#     assert(@car)
#   end

#   # assert_equal(exp, act)
#   # Fails unless exp == act (actual is from the program [i.e a variable])

#   def test_wheels
#     assert_equal(4, @car.wheels)
#   end

#   # assert_nil(obj)

#   def test_name_is_nil
#     assert_nil(@car.name)
#   end

#   #assert_raises(*exp) { ... }

#   def test_raise_initialize_with_arg
#     assert_raises(ArgumentError) do
#       car = Car.new(name: "Joey")
#     end
#   end

#   #assert_instance_of 
#   #assert_instance_of(cls, obj)
#   #Fails unless obj is an instance of cls.

#   def test_is_car_instance
#     assert_instance_of(Car, @car)
#   end

#   #assert_includes(collection, obj)
#   # Fails unless collection includes obj.

#   def test_includes_car
#     arr = [1,2,3]
#     arr << @car

#     assert_includes(arr, @car)
#   end



 # Descriptive style

# describe 'Car#wheels' do
#   it 'has 4 wheels' do
#     car = Car.new
#     car.wheels.must_equal 4
#   end
# end

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new
    car2 = Car.new

    car1.name = "Kim"
    car2.name = "Kim"

    assert_equal(car1, car2)          # this will pass
    assert_same(car1, car2)           # this will fail
  end
end