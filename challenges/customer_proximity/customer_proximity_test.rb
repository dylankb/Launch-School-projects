require 'minitest/autorun'
require_relative 'customer_proximity'

class CustomerProximityTest < Minitest::Test
  attr_reader :bobs_burgers

  def setup
    @bobs_burgers = Location.new(44.94379, -123.036721)
  end

  def test_valid_location_coordinates
    assert bobs_burgers.is_a? Location
  end

  def test_invalid_location_coordinates_formatting
    assert_raises(InvalidCoordinatesError) do
      Location.new("44.94379", "-123.036721")
    end
  end

  def test_invalid_location_coordinates
    assert_raises(InvalidCoordinatesError) do
      Location.new(44.94379, -181.12134)
    end
  end

  def test_if_location_is_within_a_given_distance
    distance_in_kilometers = 5
    city_hall = Location.new(44.9361354, -123.0417435)
    distance_between = DistanceCalculator.new(bobs_burgers, city_hall)
    within_5_km = distance_between.within_kilometers?(distance_in_kilometers)

    assert_equal(within_5_km, true)
  end

  def test_if_location_is_outside_a_given_distance
    distance_in_kilometers = 5
    tokyo = Location.new(35.6894875, 139.69170639999993)
    distance_between = DistanceCalculator.new(bobs_burgers, tokyo)
    within_5_km = distance_between.within_kilometers?(distance_in_kilometers)

    assert_equal(within_5_km, false)
  end
end
