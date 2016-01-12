require 'pry'
# Tic Tac Toe is a two player board game.
# Each player is assigned a mark, can can make one mark per turn.
# The player with three marks in a row wins

# Nouns: player, board, mark, 
# Verbs: move

# Board
# Player
# - mark
# - move
# Game

class Board
  INITIAL_MARKER = ' '

  def initialize
    @squares = {}
    (1..9).each {|key| @squares[key] = Square.new(INITIAL_MARKER)}
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def empty_squares_keys
    empty_squares = @squares.select { |key, info| info.marker == ' ' }
    empty_squares.keys
  end

  def full?
    empty_squares_keys.empty?
  end

  def find_human_moves
    human_squares = @squares.select { |key, info| info.marker == 'X' }
    human_squares.keys
  end

  def find_computer_moves
    computer_squares = @squares.select { |key, info| info.marker == 'O' }
    computer_squares.keys
  end    
end

class Square
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def move
  end
end


class Game
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  WIN_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  PRIORITY_MOVE = 5

  attr_reader :board, :human, :computer
  #attr_writer :human_moves

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts 'Welcome to Tic-Tac-Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing. Goodbye!'
  end

  def joinor
    pretty_keys = board.empty_squares_keys
    pretty_keys[-1] = 'or ' + board.empty_squares_keys[-1].to_s
    pretty_keys.join(', ')
  end

  def display_board
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def human_move
    puts "Choose a square: #{joinor}"
    square = ''
    loop do
      square = gets.chomp.to_i
      break if board.empty_squares_keys.include?(square)
      puts 'Sorry, that\'s not a valid choice'
    end

    board.set_square_at(square, human.marker) 
  end

   

  def evaluate_offensive_or_defensive_moves
    moves = []

    WINNING_LINES.each do |line|
      squares_to_check = board.find_human_moves if move_type == :offense
      squares_to_check = board.find_computer_moves if move_type == :defense
      move_key = line - squares_to_check
      if moves.size == 1 && board.squares[moves[0]] == BLANK_MARK
        return moves[0]
      end
    end
    nil
  end

  def evaluate_moves(brd)
    if evaluate_offensive_or_defensive_moves(:offense)
      evaluate_offensive_or_defensive_moves(:offense)
    elsif evaluate_offensive_or_defensive_moves(:defense)
      evaluate_offensive_or_defensive_moves(:defense)
    elsif board.squares[PRIORITY_MOVE] == BLANK_MARK
      PRIORITY_MOVE 
    else
      empty_squares(brd).sample
    end
  end


  def computer_move
    square = board.empty_squares_keys.sample
    board.set_square_at(square, computer.marker)
  end

  def check_for_winner
    human_moves = board.find_human_moves
    comp_moves = board.find_computer_moves
    WIN_LINES.each do |line|
      #binding.pry
      if (line - human_moves).empty?
        return "You win!"
      elsif (line - comp_moves).empty?
        return "Computer wins!"
      end
    end
    nil
  end

  def winner?
    !!check_for_winner
  end

  def display_result
    puts "#{check_for_winner}"
  end

  def play
    display_welcome_message
    display_board
    loop do
      human_move
      break if winner? || board.full?

      computer_move
      break if board.full?
      display_board
      #break if winner? || !empty_squares?
    end
    display_result
    display_goodbye_message
  end
end

Game.new.play

