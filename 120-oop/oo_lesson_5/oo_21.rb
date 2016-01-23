require 'pry'

module Clearable
  def clear
    system 'clear' or system 'cls'
  end
end

module Recordable

  def record_action(actions, action, card=:none)
    if card == :none
      actions << "#{name} #{action} at #{total}"
    else
      actions << "#{name} #{action} a #{card}"
    end
  end
end

class Deck
  attr_reader :cards

  def initialize
    reset
  end

  def reset
    @cards = []
    %w(2 3 4 5 6 7 8 9 10 J Q K A).each do |face_value|
      %w(H C D S).each do |suit|
        @cards << Card.new(face_value, suit)
      end
    end
    @cards.shuffle!
  end

  def deal
    cards.pop
  end
end

class Card
  attr_reader :face_value, :suit

  def initialize(face_value, suit)
    @face_value = face_value
    @suit = suit
  end

  def to_s
    "#{pretty_output(face_value)} of #{pretty_output(suit)}"
  end

  def pretty_output(string)
    case string
    when 'H' then 'Hearts'
    when 'C' then 'Clubs'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      string
    end
  end

end

class Player
  include Recordable
  attr_accessor :hand, :name

  def initialize
    reset
    get_name
  end

  def reset
    @hand = []
  end

  def show_hand(show)
    puts "--- #{name}: ---"
    if show == :hole
      hand.each_with_index do |card, index|
        if hand.size - 1 == index
          puts '?'
        else
          puts "#{card}"
        end
      end
    else
      hand.each do |card|
        puts "#{card}"
      end
    end
    puts "=> Total: #{total}"
    puts ""
  end

  def add_card(card)
    hand << card
  end

  def busted?
    total > Game::TWENTYONE
  end

  def total
    sum = 0

    hand.each do |card|
      if card.face_value == 'A'
        sum += 11
      else
        sum += (card.face_value.to_i == 0) ? 10 : card.face_value.to_i
      end
    end

    hand.select {|card| card.face_value == 'A'}.size.times do
      break if sum <= Game::TWENTYONE
      sum -= 10
    end
    sum
  end
end

class User < Player
  include Clearable

  def get_move
    puts 'Do you want to hit or stay?(h/s)'
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if answer.start_with?('h','s')
    end
    answer
  end

  def get_name
    clear
    puts "What's your name?"
    loop do
      @name = gets.chomp
      break unless @name.empty?
    end
  end
end

class Dealer < Player

  def get_name
    @name = ['Tron', 'Dolly', 'Fat Man', 'Lttle Boy'].sample
  end
end

class Game
  include Clearable
  attr_accessor :deck, :user, :dealer, :cards, :actions

  TWENTYONE = 21
  DEALER_STAY_MIN = 17

  def initialize
    @deck = Deck.new
    @user = User.new
    @dealer = Dealer.new
    @actions = []
  end

  def start
    clear
    display_welcome_message
    loop do
      game_intro
      game_round
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  def game_intro
    puts "Dealing cards..."
    puts ""
    sleep(2)
    deal_initial_hands
  end

  def game_round
    user_turn
    user.record_action(actions, 'busted') if user.busted?
    dealer_turn
    display_result
    puts display_twentyone if twentyone?
  end

  def play_again?
    puts 'Would you like to play again?(y/n)'
    answer = nil
    loop do 
      answer = gets.chomp
      break if answer.start_with?('y', 'n')
    end

    answer.start_with?('y')
  end

  def reset
    deck.reset
    user.reset
    dealer.reset
    @actions = []
    puts "Ok, let's play again!"
    puts ""
  end

  def display_welcome_message
    puts "Welcome to Blackjack!"
    puts ""
  end

  def deal_initial_hands
    2.times do
      user.add_card(deck.deal)
      dealer.add_card(deck.deal)
    end
  end

  def display_game_action(show=:hole)
    clear
    actions.each { |action| puts action }
    puts ""
    show_player_hands(show)
  end

  def show_player_hands(show=:hole)
    user.show_hand(:flop)
    dealer.show_hand(show)
  end

  def get_card
    deck.deal
  end

  def user_turn
    while !user.busted?
      display_game_action
      answer = user.get_move
      if answer.start_with?('h')
        user.add_card(get_card)
        user.record_action(actions, 'drew', get_card)
      elsif answer.start_with?('s')
        user.record_action(actions, 'stays')
        break
      end
      display_game_action
    end
    display_game_action
  end

  def dealer_turn
    loop do
      break if user.busted?
      sleep(1.5)
      if dealer.total < 17
        new_card = deck.deal
        dealer.add_card(get_card)
        dealer.record_action(actions, 'drew', new_card)
      else
        dealer.busted? ? dealer.record_action(actions, 'busts') : dealer.record_action(actions, 'stays')
        break
      end
      display_game_action(:flop)
    end
    display_game_action(:flop)
  end

  def display_goodbye_message
    puts ""
    puts "Thanks for playing Blackjack. Goodbye!"
  end

  def evalutate_result
    if user.busted?
      :dealer
    elsif dealer.busted?
      :user
    elsif user.total == dealer.total
      :tie
    else
      user.total > dealer.total ? :user : :dealer
    end
  end

  def display_result
    result = evalutate_result
    case result
    when :user
      puts "#{user.name} won with #{user.total}!!"
    when :dealer
      puts "#{dealer.name} won with #{dealer.total}!"
    when :tie
      puts "It was a tie at #{user.total}..."
    end
  end

  def twentyone?
    user.total == TWENTYONE || dealer.total == TWENTYONE
  end

  def display_twentyone
    user.total == 21 ? "#{user.name} got a 21!!!" : "#{dealer.name} got a 21!!!"
  end
end

Game.new.start