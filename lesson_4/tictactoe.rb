require 'pry'

BLANK_MARK = ' '
USER_MARK = 'X'
COMP_MARK = 'O'
PRIORITY_MOVE = 5

WINNING_LINES = [[1,2,3], [1,4,7], [1,5,9], [2,5,8], [3,6,9], [3,5,7], [4,5,6], [7,8,9]]

WINNING_SCORE = 5

FIRST_PLAYER = 'Choose'

def prompt(msg)
  puts "=> #{msg}"
end

def joiner(arr, punct=', ', conj='or')
  arr[-1] = "#{conj} #{arr.last}" if arr.size > 1
  arr.join(punct)
end

#rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{USER_MARK}. Computer is #{COMP_MARK}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
#rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = BLANK_MARK}
  new_board
end

def empty_squares(brd)
  brd.keys.select{ |num| brd[num] == BLANK_MARK}
end

def set_first_player
  if FIRST_PLAYER == 'Choose'
    ask_for_first_player
  elsif FIRST_PLAYER == 'Comp'
    'Comp'
  else
    'User'
  end
end

def ask_for_first_player
  prompt 'Which player should go first?:([P]layer/[C]omputer)'
  loop do
    answer = gets.chomp.downcase
    if answer.start_with?('p')
      return 'User'
    elsif answer.start_with?('c')
      return 'Comp'
    else
      prompt 'Sorry, that was not a valid choice.'
    end
  end  #Incorrect input prompt here?
end

def user_makes_move!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joiner(empty_squares(brd))}):"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      brd[square] = USER_MARK
      break
    else
      prompt "Sorry, invalid choice"
    end
  end
end

def evaluate_offensive_moves(brd)
  offensive_moves = []

  WINNING_LINES.each do |line|
    offensive_moves = (line - comp_moves(brd))
    if offensive_moves.size == 1 && brd[offensive_moves[0]] == BLANK_MARK
      return offensive_moves[0]
    end
  end
  nil
end

def evaluate_defensive_moves(brd)
  defensive_moves = []

  WINNING_LINES.each do |line|
    defensive_moves = (line - user_moves(brd))
    if defensive_moves.size == 1 && brd[defensive_moves[0]] == BLANK_MARK
      return defensive_moves[0]
    end
  end
  nil
end

def evaluate_moves(brd)
  if evaluate_offensive_moves(brd)
    evaluate_offensive_moves(brd)
  elsif evaluate_defensive_moves(brd)
    evaluate_defensive_moves(brd)
  elsif brd[PRIORITY_MOVE] == BLANK_MARK
    PRIORITY_MOVE
  else
    empty_squares(brd).sample
  end
end

def computer_places_piece!(brd)
  brd[evaluate_moves(brd)] = COMP_MARK
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def user_moves(brd)
  brd.keys.select { |mark| brd[mark] == USER_MARK }
end

def comp_moves(brd)
  brd.keys.select { |mark| brd[mark] == USER_MARK }
end

def detect_winner(brd)

  WINNING_LINES.each do |line|
    #binding.pry
    if (line - user_moves(brd)).empty?
      return "User"
    elsif (line - comp_moves(brd)).empty?
      return "Comp"
    end
  end
  nil
end

def ask_to_play_again
  answer = ''
  loop do 
    prompt("Would you like to play again? (Y/N)")
    answer = gets.chomp.downcase
    break if answer.start_with?('y', 'n')
    prompt("Sorry, that's not a valid result")
  end
  answer
end

def display_game_outcome(brd)
  if someone_won?(brd)
    prompt "#{detect_winner(brd)} won!"
  else
    prompt "It's a tie"
  end
end

def play_again?
  if ask_to_play_again.start_with?('y')
    true
  else
    false
  end
end

def count_score(brd)
  user_score = 0
  comp_score = 0
  if detect_winner(brd) == "User"
    user_score += 1
  elsif detect_winner(brd) == "Comp"
    comp_score += 1
  end
  [user_score,comp_score]
end 

def detect_match_winner(scores)
  if scores[0] == WINNING_SCORE
    return "User wins match!"
  elsif scores[1] == WINNING_SCORE
    return "Comp wins match!"
  end
end

def match_over?(scores)
  !!detect_match_winner(scores)
end

def game_play(brd, first_player)
  loop do
    display_board(brd)
    if first_player == 'User'
      user_makes_move!(brd)
      break if board_full?(brd) || someone_won?(brd)
      computer_places_piece!(brd)
      break if board_full?(brd) || someone_won?(brd)
    elsif first_player == 'Comp'
      computer_places_piece!(brd)
      display_board(brd)
      break if board_full?(brd) || someone_won?(brd)
      user_makes_move!(brd)
      break if board_full?(brd) || someone_won?(brd)
    end
  end
  display_board(brd)
end

def run
  player_scores = [0,0]

  loop do
    board = initialize_board
    display_board(board)
    first_player = set_first_player
    game_play(board, first_player)
    
    display_game_outcome(board)

    player_scores[0] += count_score(board)[0]
    player_scores[1] += count_score(board)[1]

    detect_match_winner(player_scores)
    if match_over?(player_scores)
      prompt detect_match_winner(player_scores)
      break
    end
    
    break unless play_again?
  end
  prompt 'Thanks for playing Tic-Tac-Toe!'
end

run