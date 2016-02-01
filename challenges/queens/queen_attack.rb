require 'pry'

class Queens
  attr_reader :white, :black, :positions
  attr_accessor :board

  YS = *(1..8)
  XS = *(1..8)
  BOARD = YS.product(XS)

  def initialize(positions={white: [0,3], black: [7,3]})
    @positions = positions
    @white = positions[:white]
    @black = positions[:black]
    @board = BOARD
    raise ArgumentError if white == black
  end

  def build_lines
    binding.pry
    @board[@board.index(white)] = 'W'
    @board[@board.index(black)] = 'B'
  end

  def to_s
    #binding.pry
    build_lines
    output = @board.each_slice(8).to_a
    p output
    output.each do |position| 
      puts '-' if position.is_a?(Array)
      puts 'W' if position == white
      puts 'B' if position == black
    end
  end
end

queens = Queens.new
queens.to_s

    # output = @board.each_slice(8)
    # output.each do |position| 
    #   puts '-' if position.is_a?(Array)}
    #   puts 'W' if position == white
    #   puts 'B' if position == black
