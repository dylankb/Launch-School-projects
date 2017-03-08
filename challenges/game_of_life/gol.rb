# 1. A cell by itself dies of starvation
# 2. 2 or 3 neighbors - lives to next generation
# 3. 3 live cells - lives to next generation
# 4. A cell with three or more neighbors dies of overcrowding

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
    @board[location].state == :alive
  end

  def reset_squares
    @board = {}
  end

  def set_up
    3.times do |x|
      3.times do |y|
        create_cell(Location.new(x, y))
      end
    end
  end

  def neighbors_alive_in_next_generation(location)
    location.neighbors.select do |neighbor|
      cell = find_cell_by_coordinates(neighbor)
      cell ? cell.state == :alive : nil
    end
  end

  def alive_in_next_generation?(location)
    neighbors_alive = neighbors_alive_in_next_generation(location)

    if find_cell(location).state == :alive
      if neighbors_alive.count < 2 || neighbors_alive > 3
        return false
      end
    else
      if neighbors_alive.count != 3
        return false
      end
    end

    true
  end

  def find_cell_by_coordinates(neighbor)
    cell = @board.find do |location|
      (neighbor.x == location[0].x) && (neighbor.y == location[0].y)
    end
    cell ? cell[1] : nil
  end

  def find_cell(location)
    @board[location]
  end
end

class Location
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    # raise "Duplicate location" unless unique_location?
  end

  def neighbors
    [ Location.new(x+1, y+1),
      Location.new(x+1, y),
      Location.new(x+1, y-1),
      Location.new(x, y+1),
      Location.new(x, y-1),
      Location.new(x-1, y+1),
      Location.new(x-1, y),
      Location.new(x-1, y-1),
    ]
  end
end

class Cell
  attr_reader :state

  def initialize(location)
    @state = :alive
    @location = location
  end

  def alive_in_next_generation?
    @location.neighbors
  end
end

world = World.new
world.set_up



# Improvements
# -
# class World
# def set_living_at(location)
# #...
# end end
