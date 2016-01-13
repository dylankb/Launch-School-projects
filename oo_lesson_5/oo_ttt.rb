class Board
  attr_reader :squares
  BLANK_MARK = ' '

  def initialize
    @squares = {}
    reset
  end
  
  def draw
    clear
    puts ""
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----+-----+----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----+-----+----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
    puts ""
  end

  def clear
    system 'clear' or system 'cls'
  end

  def clear_screen_and_display_board
    clear
    draw
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def empty_squares_keys
    empty_squares = @squares.select { |key, info| info.marker == ' ' }
    empty_squares.keys
  end

  def full?
    empty_squares_keys.empty?
  end

 def find_marks
    marks = {}
    @squares.each do |key, info|
      if info.marker == BLANK_MARK
        next
      elsif marks.has_key?(info.marker)
        marks[info.marker] << key
      else
        marks[info.marker] = []
        marks[info.marker] << key
      end
    end
    marks
  end

  def find_human_moves
    #binding.pry
    find_marks[Game::HUMAN_MARKER]
  end

  def find_computer_moves
    computer_moves = find_marks[Game::COMPUTER_MARKER] || []
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new(BLANK_MARK)}
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
end


class Game
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  WIN_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  PRIORITY_MOVE = 5

  attr_reader :board, :human, :computer

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

  def human_move
    puts "Choose a square: #{joinor}"
    square = ''
    loop do
      square = gets.chomp.to_i
      break if board.empty_squares_keys.include?(square)
      puts 'Sorry, that\'s not a valid choice'
    end

    board.[]=(square, human.marker) 
  end

  def evaluate_offensive_or_defensive_moves(move_type)
    moves = []
    WIN_LINES.each do |line|
      squares_to_check = board.find_computer_moves if move_type == :offense
      squares_to_check = board.find_human_moves if move_type == :defense
      moves = line - squares_to_check
      if moves.size == 1 && board.squares[moves[0]].marker == Board::BLANK_MARK
        return moves[0]
      end
    end
    nil
  end

  def evaluate_moves
    if evaluate_offensive_or_defensive_moves(:offense)
      evaluate_offensive_or_defensive_moves(:offense)
    elsif evaluate_offensive_or_defensive_moves(:defense)
      evaluate_offensive_or_defensive_moves(:defense)
    elsif board.squares[PRIORITY_MOVE].marker == Board::BLANK_MARK
      PRIORITY_MOVE 
    else
      board.empty_squares_keys.sample
    end
  end

  def computer_move!
    board.[]=(evaluate_moves, computer.marker)
  end

  def computer_move
    square = board.empty_squares_keys.sample
    board.[]=(square, computer.marker)
  end

  # def winning_mark
  #   marks = board.find_marks
  # end

  def winning_marker
    player_marks = board.find_marks
    player_marks.each do |mark, marks|
      WIN_LINES.each do |line|
        if (line - marks).empty?
          return mark.to_sym
        end
      end
    end
    nil
  end

  def winner?
    !!winning_marker
  end

  def display_winning_message
    result = winning_marker

    case result
    when :X
      puts "You won the game!"
    when :O
      puts "Computer won the game!"
    end
  end


  def display_result
    if winner?
      display_winning_message
    else
      puts 'It\'s a tie!'
    end
  end

  def play_again?
    answer = ''
    puts 'Would you like to play again?(y/n)'
    loop do
      answer = gets.chomp.downcase
      break if answer.start_with?('y','n')
      puts 'Sorry, that\'s not a valid response'
    end
    answer == 'y'
  end

  def reset
    board.reset
    board.clear
    puts "Ok, let's play again!"
    puts ""
  end

  def play
    display_welcome_message
    board.clear
    loop do
      board.draw
      loop do
        human_move
        board.clear_screen_and_display_board
        break if winner? || board.full?
        computer_move!
        board.clear_screen_and_display_board
        break if winner? || board.full?
      end
      display_result
      break unless play_again?
      reset
    end
    display_goodbye_message
  end
end

Game.new.play
