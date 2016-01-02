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
end

def sum_cards(player)
  player.inject do |sum, face_value|
    if face_value[1].to_i.to_s = face_value[1]
      sum += face_value
    else
      sum += 10
    end
  end
end


def comp_hit_or_stay(deck, comp)
end

current_player = FIRST_PLAYER

deck = initialize_deck
shuffle_deck(deck)
deal_initial_hand(deck, user, comp)

p user
p comp

hit_or_stay(deck, user)

p user
p comp
puts "User cards: #{sum_cards(user)}"
