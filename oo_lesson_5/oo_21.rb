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
  attr_accessor :hand, :name

  def initialize(name)
    @hand = []
    @name = name
  end

  def show_hand
    puts "--- #{name}: ---"
    hand.each do |card|
      puts "#{card}"
    end
    puts "=> Total: #{total}"
    puts ""
  end

  def hit(card)
    self.hand << card
  end

  def busted?
    self.total > Game::BLACKJACK
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
      break if sum <= Game::BLACKJACK
      sum -= 10
    end
    sum
  end
end

class User < Player
  def initialize(name)
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
end

class Dealer < Player
  def initialize(name)
    super
  end
end

class Game
  attr_accessor :deck, :user, :dealer, :cards

  BLACKJACK = 21

  def initialize
    @deck = Deck.new
    @user = User.new('You')
    @dealer = Dealer.new('Dealer')
  end

  def display_welcome_message
    puts "Welcome to Blackjack!"
    puts ""
  end

  def deal_initial_hands
    2.times do
      user.hit(deck.deal)
      dealer.hit(deck.deal)
    end
  end

  def show_player_hands
    user.show_hand
    dealer.show_hand
  end

  def user_turn
    while !user.busted?
      show_player_hands
      answer = user.get_move
      clear
      if answer.start_with?('h')
        new_card = deck.deal
        puts "#{user.name} drew #{new_card}"
        puts ""
        user.hit(new_card)
      elsif answer.start_with?('s')
        puts "#{user.name} chose to stay"
        break
      end
    end
  end

  def dealer_turn
    clear
    loop do
      show_player_hands
      if dealer.total < 17
        new_card = deck.deal
        puts "#{dealer.name} took a #{new_card}"
        dealer.hit(new_card)
      else
        if dealer.busted?
          puts 'Dealer busted!'
        else 
          puts 'Dealer stays'
        end
        break
      end
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Blackjack. Goodbye!"
  end

  def evalutate_result
    if user.busted?
      :dealer
    elsif dealer.busted?
      :user
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
      puts "#{user.name} won!!"
    when :dealer
      puts "#{dealer.name} won!"
    end
  end

  def display_scores
    puts "#{user.name} had #{user.total}"
    puts "#{dealer.name} had #{dealer.total}"
  end

  def clear
    system 'clear' or system 'cls'
  end

  def game_round
    user_turn
    if user.busted?
      puts "#{user.name} busted!"
      display_result
    else
      dealer_turn
      display_scores
      display_result
    end
  end

  def start
    game_intro
    game_round
    display_goodbye_message
  end
end

Game.new.start