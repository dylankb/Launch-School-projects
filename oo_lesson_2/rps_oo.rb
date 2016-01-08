require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('messages.yml')

module Sayable
  def say(msg)
    puts "=> #{msg}"
  end
end

class Player
  attr_accessor :move, :name, :wins, :won_game

  def initialize
    get_name
    @wins = 0
  end
end

class Human < Player
  include Sayable
  def game_intro
    say MESSAGES['intro_question']
    loop do
      answer = gets.chomp.downcase
      if answer == 'y'
        say MESSAGES['game_start']
        break
      elsif answer == 'n'
        say MESSAGES['explanation']
      else
        say MESSAGES['wrong_y-n_response']
      end
    end
  end

  def get_name
    say MESSAGES['name?']
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
      #binding.pry 
      say MESSAGES['hand_choice']
      choice = gets.chomp
      break if RPSGame::MOVES.keys.include?(choice)
      say MESSAGES['confirm_choice']
    end
    self.move = choice
  end
end

class Computer < Player

  def get_name
    self.name = ['C3PO', 'Wall-E', 'BB8'].sample
  end

  def choose
    self.move = RPSGame::MOVES.keys.sample
  end
end

class RPSGame
  include Sayable
  attr_accessor :human, :computer

  MOVES = {'r'=>'rock', 'p'=>'paper', 'sc'=>'scissors' ,'l'=>'lizard', 'sp'=>'spock'}
  WINS = {'r' => ['sc', 'l'],'sc' => ['p', 'l'], 
          'p' => ['r', 'sp'], 'l' => ['p', 'sp'], 
          'sp' => ['r', 'sc']}

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def compare
    if WINS.values_at(human.move).flatten.include?(computer.move)
      human.won_game = true
      human.wins += 1
    elsif WINS.values_at(computer.move).flatten.include?(human.move)
      computer.won_game = true
      computer.wins += 1
    end
  end

  def display_moves
    if human.won_game
      say "#{human.name} wisely chose #{human.move}."
    else
      say "#{human.name} chose #{human.move}."
    end
    if computer.won_game
      say "#{computer.name} wisely chose #{computer.move}"
    elsif human.move == computer.move
      say "#{computer.name} also chose #{computer.move}"
    else
      say "#{computer.name} chose #{computer.move}"
    end
  end

  def display_winner
    if human.won_game
      say "#{human.name} won!"
    elsif computer.won_game
      say "#{computer.name} won!"
    else
      say MESSAGES['tie']
    end
  end

  def play_again?
    say MESSAGES['ask_play_again']
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if answer.start_with?('y','n')
      say MESSAGES['wrong_y-n_response']
    end
    answer.start_with?('y')
  end

  def display_goodbye_message
    say MESSAGES['goodbye']
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