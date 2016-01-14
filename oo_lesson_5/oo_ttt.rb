class Board
  attr_reader :squares
  BLANK_MARK = ' '

  def initialize
    @squares = {}
    reset
  end
  
  def draw
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
    marks = { Game::HUMAN_MARKER => [], Game::COMPUTER_MARKER=> []}
    @squares.each do |key, info|
      next if info.marker == BLANK_MARK
      marks[info.marker] << key
    end
    marks
  end

  def find_human_moves
    find_marks[Game::HUMAN_MARKER]
  end

  def find_computer_moves
    find_marks[Game::COMPUTER_MARKER] || []
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new(BLANK_MARK) }
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
  attr_accessor :name
  attr_reader :marker

  def initialize(marker)
    @marker = marker
    get_name
  end

  def get_name
    if self.marker == Game::HUMAN_MARKER
      puts "Welcome to Tic-Tac-Toe!"
      puts "What's your name?"
      loop do
        self.name = gets.chomp
        break unless self.name.empty?
      end
    elsif self.marker == Game::COMPUTER_MARKER
      self.name = ['BB8','Watson','Deep Blue'].sample
    end
  end
end

class Game
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  WIN_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],[3, 6, 9], [1, 5, 9], [3, 5, 7]]
  PRIORITY_MOVE = 5
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    loop do
      display_board
      round_of_game_play
      display_result
      break unless play_again?
      reset

    end
    display_goodbye_message
  end

  private

  def display_goodbye_message
    puts 'Thanks for playing. Goodbye!'
  end

  def joinor
    pretty_keys = board.empty_squares_keys
    pretty_keys[-1] = 'or ' + board.empty_squares_keys[-1].to_s
    pretty_keys.join(', ')
  end

  def clear
    system 'clear' or system 'cls'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_move
    puts "Choose a square: #{joinor}"
    square = ''
    loop do
      square = gets.chomp.to_i
      break if board.empty_squares_keys.include?(square)
      puts 'Sorry, that\'s not a valid choice'
    end

    board[square] = human.marker
  end

  def evaluate_offensive_or_defensive_moves(move_type)
    moves = []
    Game::WIN_LINES.each do |line|
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
    if offensive_moves = evaluate_offensive_or_defensive_moves(:offense)
      offensive_moves
    elsif defensive_moves = evaluate_offensive_or_defensive_moves(:defense)
      defensive_moves
    elsif board.squares[Game::PRIORITY_MOVE].marker == Board::BLANK_MARK
      Game::PRIORITY_MOVE
    else
      board.empty_squares_keys.sample
    end
  end

  def computer_move
    board.[]=(evaluate_moves, computer.marker)
  end

  def winning_marker
    player_marks = board.find_marks
    player_marks.each do |mark, marked|
      Game::WIN_LINES.each do |line|
        if (line - marked).empty?
          return mark
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
    when Game::HUMAN_MARKER
      puts "You won the game!"
    when Game::COMPUTER_MARKER
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
      break if answer.start_with?('y', 'n')
      puts 'Sorry, that\'s not a valid response'
    end
    answer == 'y'
  end

  def reset
    board.reset
    clear
    puts "Ok, let's play again!"
    puts ""
    display_board
    @current_marker = Game::FIRST_TO_MOVE
  end

  def current_player_move
    if @current_marker == Game::HUMAN_MARKER
      human_move
    else
      computer_move
    end
  end

  def alternate_player
    if @current_marker == Game::HUMAN_MARKER
      @current_marker = Game::COMPUTER_MARKER
    else
      @current_marker = Game::HUMAN_MARKER
    end
  end

  def display_board
    clear
    puts "#{human.name}'s marker: #{human.marker} | #{computer.name}'s marker: #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def round_of_game_play
    loop do
      current_player_move
      clear_screen_and_display_board
      break if winner? || board.full?
      alternate_player
    end
  end
end

game = Game.new
game.play
