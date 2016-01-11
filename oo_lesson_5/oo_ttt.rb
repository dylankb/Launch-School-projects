Tic Tac Toe is a two player board game.
Each player is assigned a mark, can can make one mark per turn.
The player with three marks in a row wins

Nouns: player, board, mark, 
Verbs: move

Board
Player
- mark
- move
Game

class Board
  def initialize
  end
end

class Square
  def initialize
  end
end

class Player
  def initialize
  end

  def mark
  end

  def move
  end

end

class Game
  def initialize
  end

  def display_welcome_message
    puts 'Welcome to Tic-Tac-Toe!'
  end

  def display_goodbye_message
    puts 'Thanks for playing. Goodbye!'
  end

  def play
    display_welcome_message
    loop do
      display_board
      user.move
      break if winner? || !empty_squares?

      computer.move
      display_board
      break if winner? || !empty_squares?

    end
    display_result
    display_goodbye_message
  end
end

Game.new.play

  # puts ""
  # puts "     |     |"
  # puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  # puts "     |     |"
  # puts "-----+-----+----"
  # puts "     |     |"
  # puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  # puts "     |     |"
  # puts "-----+-----+----"
  # puts "     |     |"
  # puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  # puts "     |     |"
  # puts ""