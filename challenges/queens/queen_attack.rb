class Queens
  attr_reader :white, :black, :positions, :board

  ROW = (0..7).to_a
  COLUMN = (0..7).to_a
  BOARD = ROW.product(COLUMN)

  def initialize(positions={white: [0, 3], black: [7, 3]})
    @positions = positions
    @white = positions[:white]
    @black = positions[:black]
    @board = BOARD.clone
    raise ArgumentError if white == black
  end

  def attack?
    white_moves = get_queen_moves(white)
    black_moves = get_queen_moves(black)
    white_moves.include?(black) && black_moves.include?(white)
  end

  def to_s
    mark_queen_locations
    @board.map! { |arr| ['W','B'].include?(arr) ? arr : '_' }
    @board = @board.each_slice(8).to_a
    @board.map { |row| row.join(' ') }.join("\n")
  end

  def get_queen_moves(queen)
    straight_moves = get_straights(queen)
    diagonal_moves = get_diagonals(queen)
    (straight_moves + diagonal_moves).delete_if {|arr| arr == queen }
  end

  def mark_queen_locations
    @board.map! { |arr| white == arr ? 'W' : arr }
    @board.map! { |arr| black == arr ? 'B' : arr }
  end

  def get_straights(queen)
    [queen[0]].product(ROW) + COLUMN.product([queen[1]])
  end

  def get_diagonals(queen)
    queen_moves = []
    
    queen_copy = queen.dup
    while queen_copy.dup.max
      queen_moves << [ queen_copy[0] += 1, queen_copy[1] += 1]
    end

    queen_copy2 = queen.dup
    while queen_copy2[0] > 0 && queen_copy2[1] > 0
      queen_moves << [ queen_copy2[0] -= 1, queen_copy2[1] -= 1]
    end

    queen_copy3 = queen.dup
    while queen_copy3[0] > 0 && queen_copy3[1] < 7
      queen_moves << [ queen_copy3[0] -= 1, queen_copy3[1] += 1]
    end

    queen_copy4 = queen.dup
    while queen_copy4[0] < 7 && queen_copy4[1] > 0
      queen_moves << [ queen_copy4[0] += 1, queen_copy4[1] -= 1]
    end

    queen_moves
  end
end