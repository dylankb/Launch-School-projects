# 1. Live cell by itself - dies of starvation
# 2. Live cell with less than two living neighbors - dies by starvation
# 2. Live cell with 2 or 3 neighbors - lives to next generation
# 3. Live cell with more than 3 living neighbors - dies by overcrowding
# 4. Dead cell with 3 living neighbors - comes back to life
require 'pry'

class World
  attr_reader :board

  def initialize
    @board = {}
    reset_squares
  end

  def empty?
    @board.size == 0
  end

  def create_cell(location)
    @board[location] = Cell.new(location)
  end

  def alive_at?(location)
    @board[location].alive? == true
  end

  def reset_squares
    @board = {}
  end

  def set_up
    3.times do |x|
      3.times do |y|
        create_cell(Location.new(x, y, @board))
      end
    end
  end

  def find_cell(location)
    @board[location]
  end
end

class Location
  attr_reader :x, :y

  def initialize(x, y, board)
    @x = x
    @y = y
    @board = board
    # raise "Duplicate location" unless unique_location?
  end

  # This method could/should return actual cells eventually
  def neighbor_locations
    # Do this in a nested loop
    [ Location.new(x+1, y+1, @board),
      Location.new(x+1, y, @board),
      Location.new(x+1, y-1, @board),
      Location.new(x, y+1, @board),
      Location.new(x, y-1, @board),
      Location.new(x-1, y+1, @board),
      Location.new(x-1, y, @board),
      Location.new(x-1, y-1, @board),
    ]
  end

  def find_cell_by_location(location)
    neighbor_location = @board.keys.find do |neighbor_location|
      (location.x == neighbor_location.x) && (location.y == neighbor_location.y)
    end

    @board[neighbor_location]
  end
end

class Cell
  attr_reader :alive

  def initialize(location)
    @alive = true
    @location = location
  end

  def alive?
    @alive
  end

  def stable_environment?(neighbors_alive_count)
    neighbors_alive_count == 2 || neighbors_alive_count == 3
  end

  def regeneration_environment?(neighbors_alive_count)
    neighbors_alive_count == 3
  end

  def alive_in_next_generation?
    neighbors_alive_count = neighbors_currently_alive.count

    if alive?
      return stable_environment?(neighbors_alive_count)
    else
      return regeneration_environment?(neighbors_alive_count)
    end

    false
  end

  def neighbors_currently_alive
    @location.neighbor_locations.select do |neighbor_location|
      neighbor = @location.find_cell_by_location(neighbor_location)
      neighbor ? neighbor.alive? == true : false
    end
  end
end

world = World.new
world.set_up

# IMPROVEMENTS

# class World
# def set_living_at(location)
# #...
# end end

# 2) It's odd that I need a find_neighbor_cell_by_a_location(neighbor_location), but
# not sure a way around it

# - Location knowing about board and the ACTUAL neighbors might help...

# 3) Cell should know if it's alive in next generation?
# Current the world does because it requires @board knowledge, but that would require location

# IDEAS
# 1. Location knows about board
# create_cell(Location.new(x, y, @board))

# 2. Cell knows location
# find_cell_location
#    @location
#  end

# def initialize(location)
#   ...
#   @location = location
# end

# QUESTIONS

# 1. Is it better to have a hash of locations with cell values, than having an array of Cells with location ivars that hold a Location class?
