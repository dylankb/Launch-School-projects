require 'pry'

class Player
  attr_accessor :move, :name, :win

  def initialize
    get_name
  end
end

class Human < Player
  def get_name
    puts "Welcome to Rock, Paper, Scissors."
    puts "What's your name?"
    n = ''
    loop do
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, you must enter something here."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do 
      puts "Please choose rock, paper, or scissors"
      choice = gets.chomp
      break if ['rock','paper','scissors'].include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = choice
  end
end

class Computer < Player

  def get_name
    self.name = ['C3PO', 'Wall-E', 'BB8'].sample
  end

  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end
end

class RPSGame
  attr_accessor :human, :computer

  WINNING_MOVES = {'rock' =>'scissors', 'paper' => 'rock', 'scissors'=>'rock' }

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_moves
    #binding.pry
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}"
  end

  def compare
    if WINNING_MOVES[human.move] == computer.move
      human.win = true
    elsif WINNING_MOVES[computer.move] == human.move
      computer.win = true
    end
  end

  def display_winner
    if human.win
      puts "#{human.name} won!"
    elsif computer.win
      puts "#{computer.name} won!"
    else
      puts "It was a tie..."
    end
  end

  def play_again?
    puts 'Would you like to play again?'
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if answer.start_with?('y','n')
      puts "Sorry, that was an invalid response. Choose y or n."
    end
    answer.start_with?('y')
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def play
    loop do
      human.choose
      computer.choose
      compare
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play