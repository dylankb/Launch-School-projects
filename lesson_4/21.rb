require 'pry'

user = []
comp = []
FIRST_PLAYER = user

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  faces = %w(2 3 4 5 6 7 8 9 10 J K Q A)
  suits = %w(H S D C)
  suits.product(faces)
end

def shuffle_deck(deck)
  deck.shuffle!
end

def deal_card(deck, player)
  new_card = deck.pop
  player << deck.pop
  new_card
end

def deal_initial_hand(deck, player1, player2)
  2.times do
    player1 << deck.pop
    player2 << deck.pop
  end
end

def get_hit_or_stay_request(deck)
  answer = nil
  prompt 'Would you like to hit or stay? (hit/stay)?'
  loop do
    answer = gets.chomp.downcase
    break if answer.start_with?('h','s')
    prompt 'Sorry, that\'s not a valid response'
  end
  answer
end

def hit_or_stay(deck, user)
  answer = get_hit_or_stay_request(deck)
  if answer.start_with?('h')
    prompt "User drew a #{deal_card(deck, user)}"
  else
    prompt "User stays"
  end
  answer
end

def sum_cards(player)
  face_values = player.map { |card| card[1] }
  sum = 0
  
  face_values.each do |value|
    if value == 'A'
      sum += 11
    else
      sum += (value.to_i == 0 ? 10 : value.to_i)
    end
  end
    
  face_values.select { |value| value == 'A'}.count.times do
    break if sum <= 21
    sum -=10
  end
  sum
end


def comp_hit_or_stay(deck, comp)
  loop do
    if sum_cards(comp) < 17
      deal_card(deck, comp)
      prompt "User drew a #{deal_card(deck, comp)}"
    else
      break
    end
  end
end

current_player = FIRST_PLAYER

deck = initialize_deck
shuffle_deck(deck)
deal_initial_hand(deck, user, comp)

p user
p comp

p sum_cards(user)
loop do
  choice = hit_or_stay(deck, user)
  break if choice.start_with?('s') || sum_cards(user) > 21
end
comp_hit_or_stay(deck, comp)

p user
p comp
puts "User cards: #{sum_cards(user)}"
