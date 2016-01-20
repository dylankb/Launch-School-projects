module Recordable

  def hit_and_record(actions, deck)
    new_card = deck.deal
    self.add_card(new_card)
    actions << "#{self.name} drew the #{new_card} | #{self.total}"
  end

  def record_action(actions, action)
    actions << "#{self.name} #{action} at #{self.total}"
  end
end

class Deck
  attr_reader :cards

  def initialize
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
    @hand = []
    get_name
  end

  def show_hand
    puts "--- #{name}: ---"
    hand.each do |card|
      puts "#{card}"
    end
    puts "=> Total: #{total}"
    puts ""
  end

  def add_card(card)
    self.hand << card
  end

  def busted?
    self.total > Game::TWENTYONE
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
  def initialize
    super
  end

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
    puts "What's your name?"
    loop do
      @name = gets.chomp
      break unless @name.empty?
    end
  end
end

class Dealer < Player
  def initialize
    super
  end

  def get_name
    @name = ['Tron', 'Dolly', 'Fat Man', 'Lttle Boy'].sample
  end
end

class Game
  include Recordable
  attr_accessor :deck, :user, :dealer, :cards, :actions
  attr_reader :name


  TWENTYONE = 21
  DEALER_STAY_MIN = 17

  def initialize
    @deck = Deck.new
    @user = User.new
    @dealer = Dealer.new
    @actions = []
  end

  def start
    game_intro
    game_round
    display_goodbye_message
  end

  def game_round
    user_turn
    user.record_action(actions, 'busted') if user.busted?
    dealer_turn
    display_result
    puts display_twentyone if twentyone?
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

  def display_game_action
    clear
    actions.each { |action| puts action }
    puts ""
    show_player_hands
  end

  def show_player_hands
    user.show_hand
    dealer.show_hand
  end

  def user_turn
    while !user.busted?
      display_game_action
      answer = user.get_move
      if answer.start_with?('h')
        user.hit_and_record(actions, deck)
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
        dealer.hit_and_record(actions, deck)
      else
        dealer.busted? ? dealer.record_action(actions, 'busts') : dealer.record_action(actions, 'stays')
        break
      end
      display_game_action
    end
    display_game_action
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

  def game_intro
    clear
    display_welcome_message
    puts "Dealing cards..."
    puts ""
    sleep(2)
    deal_initial_hands
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

  def clear
    system 'clear' or system 'cls'
  end
end

Game.new.start