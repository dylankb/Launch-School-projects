require 'pry'

class Queens
  attr_reader :positions, :board

  YS = *(1..8)
  XS = *(1..8)
  BOARD = YS.product(XS)
  EMPTY_MARK = '-'
  WHITE_MARK = 'W'
  BLACK_MARK = 'B'

  def initialize(positions={white: [3,7], black: [6,1]})
    @positions = positions
    @board = []
    XS.each do |xnum|
      YS.each do |ynum|
        @board << Position.new([xnum, ynum])
      end
    end
  end

  def to_s
    binding.pry
    puts ""
    puts "          "
    puts "  #{board[1].mark}|  #{board[2].mark}  |  #{board[3].mark}"
    puts "     |     |"
    puts "-----+-----+----"
    puts "     |     |"
    puts "  #{board[4].mark}  |  #{board[5].mark}  |  #{board[6].mark}"
    puts "     |     |"
    puts "-----+-----+----"
    puts "     |     |"
    puts "  #{board[7].mark}  |  #{board[8].mark}  |  #{board[9].mark}"
    puts "     |     |"
    puts ""
  end
end

class Position
  attr_reader :mark

  def initialize(spot)
    @mark = Queens::EMPTY_MARK
    @spot = spot
  end

  def to_s
    @mark
  end
end

queen = Queens.new
queen.to_s

# YS = *(1..8)
# XS = *(1..8)

# squares = XS.product(YS)

# x_spot = [6]
# y_spot = [7]

# x_range = x_spot.product(XS) #[[6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], #[6, 7], [6, 8]]
# y_range = YS.product(y_spot) #[[1, 7], [2, 7], [3, 7], [4, 7], [5, 7], #[6, 7], [7, 7], [8, 7]]

# danger_zone = x_range + y_range

# safe = squares - danger_zone
