GAME_WINS = 5
BLACKJACK = 21
DEALER_STAY_MIN = 17

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
  player << new_card
  new_card
end

def deal_initial_hand(deck, player1, player2)
  2.times do
    player1 << deck.pop
    player2 << deck.pop
  end
end

def get_hit_or_stay_request
  answer = nil
  prompt 'Would you like to hit or stay? (hit/stay)?'
  loop do
    answer = gets.chomp.downcase
    break if answer.start_with?('h', 's')
    prompt 'Sorry, that\'s not a valid response'
  end
  answer
end

def hit_or_stay(deck, user)
  answer = get_hit_or_stay_request
  if answer.start_with?('h')
    new_card = deal_card(deck, user)
    prompt "You drew a #{new_card[1]}"
    prompt "Your total is #{sum_cards(user)}"
  else
    prompt "You stay"
  end
  answer
end

def joinand(cards)
  cards[-1] = "and #{cards[-1]}"
  if cards.size > 2
    cards.join(', ')
  else
    cards.join(' ')
  end
end

# def display_initial_hand(name, player) 
#   face_values = player.map { |card| card[1] }
# end

def display_hand(name, player, time='play')
  face_values = player.map { |card| card[1] }
  
  if time == 'initial'
    if name == 'You'
      prompt "#{name}: #{joinand(face_values)}"
    else
      temp_face_values = face_values.clone
      temp_face_values[1]= '?'
      prompt "#{name}: #{joinand(temp_face_values)}"
    end
  else
    face_values = player.map { |card| card[1] }
    prompt "#{name}: #{joinand(face_values)}"
  end
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

  face_values.select { |value| value == 'A' }.count.times do
    break if sum <= BLACKJACK
    sum -= 10
  end
  sum
end

def dealer_hit_or_stay(deck, dealer, user)
  loop do
    break unless sum_cards(dealer) < DEALER_STAY_MIN && !busted?(user)
    new_card = deal_card(deck, dealer)
    prompt "Dealer drew a #{new_card[1]}"
  end
  display_hand("Dealer", dealer)
  prompt "Dealer total is #{sum_cards(dealer)}"
end

def busted?(player)
  sum_cards(player) > BLACKJACK
end

def evaluate_game(user, dealer)
  user_total = sum_cards(user)
  dealer_total = sum_cards(dealer)
  if busted?(user)
    :user_bust
  elsif busted?(dealer)
    :dealer_bust
  elsif user_total > dealer_total
    :user
  elsif dealer_total > user_total 
    :dealer
  else
    :tie
  end
end

def display_game_results(user, dealer)
  result = evaluate_game(user, dealer)

  case result
  when :user_bust
   prompt "You busted...The dealer wins." 
  when :dealer_bust
    prompt "The dealer busted. You win!"
  when :tie
    prompt "It's a tie..." 
  when :user
    prompt "You win!"
  when :dealer 
    prompt "Dealer wins!" 
  end
end

def count_game_wins(user, dealer, scores)
  result = evaluate_game(user, dealer)

  case result
  when :user
    scores[0] += 1
  when :dealer_bust
    scores[1] += 1
  when :user_bust
    scores[1] += 1
  when :dealer
    scores[1] += 1
  end
end

def evaluate_match(scores)
  if scores[0] == GAME_WINS
    outcome = :user
  elsif scores[1] == GAME_WINS
    outcome = :dealer
  end
end

def display_match_results(scores)
  outcome = evaluate_match(scores)

  case outcome
  when :user
    prompt "You win the match!!"
  when :dealer
    prompt "Dealer wins the match!!"
  end
end

def game_over?(scores)
  !!evaluate_match(scores)
end

def setup_game
  user = []
  dealer = []

  deck = initialize_deck
  shuffle_deck(deck)
  deal_initial_hand(deck, user, dealer)
  [deck, user, dealer]
end

def play_again?
  answer = ''
  prompt "Would you like to play again?"
  loop do
    answer = gets.chomp.downcase
    break if answer.start_with?('y', 'n')
    prompt "Sorry, that's not a valid response"
  end
  answer.start_with?('y')
end

player_scores = [0, 0]

loop do
  system 'clear'
  deck, user, dealer = setup_game
  
  prompt "You: #{player_scores[0]} Dealer: #{player_scores[1]}"
  display_hand("You", user, 'initial')
  display_hand("Dealer", dealer, 'initial')

  loop do
    choice = hit_or_stay(deck, user)
    break if choice.start_with?('s') || busted?(user)
    display_hand("You", user)
  end
  dealer_hit_or_stay(deck, dealer, user)

  display_game_results(user, dealer)
  count_game_wins(user, dealer, player_scores)

  break unless !game_over?(player_scores) && play_again?
end
display_match_results(player_scores)
