require 'minitest/autorun'
require_relative 'gol'

class WorldTest < Minitest::Test
  def test_world_is_empty?
    world = World.new
    assert world.empty?
  end

  def test_after_adding_a_cell_the_world_is_not_empty
    world = World.new
    world.create_cell(Location.new(1,2))
    refute world.empty?
  end

  def test_can_add_location
    world = World.new
    location = Location.new(1,2)
    world.create_cell(location)
    assert world.alive_at?(location)
  end

  def test_remains_alive_in_next_generation_with_two_neighbors
    world = World.new
    location = Location.new(1,2)

    cell = world.create_cell(location)
    world.create_cell(Location.new(1,1))
    world.create_cell(Location.new(2,2))
    assert world.alive_in_next_generation?(location)
  end

  # def test_is_killed_by_starvation_with_one_neighbor
  #   world = World.new
  #   location = Location.new(1,2)
  #
  #   world.create_cell(location)
  #   world.create_cell(Location.new(1,1))
  #   assert world.alive_in_next_generation?(location) == false
  # end
end
