class Game
  def self.setup(x, y, live_cells)
    game = new
    x.times do |m|
      y.times do |n|
        game.create_cell(n, m)
      end
    end
    game
  end

  def initialize
    @board = Hash.new { |hsh, k| hsh[k] = {} }
  end

  def empty?
    @board.size == 0
  end

  def create_cell(x, y)
    @board[x][y] = DeadCell.new
  end

  def enliven_cell(x, y)
    @board[x][y] = LiveCell.new
  end

  def deaden_cell(x, y)
    @board[x][y] = DeadCell.new
  end

  def cell_at(x, y)
    @board[x][y]
  end
end

class LiveCell
end
class DeadCell
end
