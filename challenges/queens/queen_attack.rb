class Queens
  attr_reader :white, :black, :positions
  attr_accessor :board

  ROW = (0..7).to_a
  COLUMN = (0..7).to_a
  BOARD = ROW.product(COLUMN)

  def initialize(positions={white: [0,3], black: [7,3]})
    @positions = positions
    @white = positions[:white]
    @black = positions[:black]
    @board = BOARD.clone
    raise ArgumentError if white == black
  end

  def attack?
    white_moves = white[0].to_s.chars.map(&:to_i).product(ROW) + white[1].to_s.chars.map(&:to_i).product(COLUMN)
    p white_moves
  end

  def to_s
    mark_queen_locations
    output = @board.map { |arr| ['W','B'].include?(arr) ? arr : '-' }
    @board = output.each_slice(8).to_a
    @board.map { |row| row.join(' ') }.join("\n")
  end

  def mark_queen_locations
    @board.map! { |arr| white == arr ? 'W' : arr }
    @board.map! { |arr| black == arr ? 'B' : arr }
  end
end

queens = Queens.new
queens.attack?
