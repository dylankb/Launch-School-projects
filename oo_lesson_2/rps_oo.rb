require 'pry'

# RPS

# Game description
# A player may choose rock, paper, or scissors.
# R > S, P > R, S > P
# The chosen moves will then be compared according to the rule above.
# A winner will then be declared based on the comparison.

# If they choose the same one it's a tie

# Extract verbs/nouncs
# Nouncs: Move/choice, rule
# Verbs: compare, choose

# Organize
# Player 
# - choose
# Move
# Rule 

# - compare



class Player
  attr_accessor :move, :win

  def initialize(player_type = 'human')
    @player_type = player_type
    @move = nil
    @win = nil
  end

  def choose
    if human?
      choice = nil
      loop do 
        puts "Please choose rock, paper, or scissors"
        choice = gets.chomp
        break if ['rock','paper','scissors'].include?(choice)
        puts "Sorry, invalid choice"
      end
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end

  def human?
    @player_type == 'human'
  end
end

WINNING_MOVES = {'rock' =>'scissors', 'paper' => 'rock', 'scissors'=>'rock' }



class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new('computer')
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors"
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_moves
    puts "You chose #{human.move}."
    puts "Computer chose #{computer.move}"
  end

  def display_winner
    if human.win
      puts "You won!"
    elsif computer.win
      puts "Computer won!"
    else
      puts "It was a tie..."
    end
  end

  def compare
    if WINNING_MOVES[human.move] == computer.move
      human.win = true
    elsif WINNING_MOVES[computer.move] == human.move
      computer.win = true
    end
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    compare
    display_moves
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play




