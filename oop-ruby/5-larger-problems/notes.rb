# Make methods private
# Add note in gdocs about accessing data via passing in params in module methods (rps/ move_history AND 21/actions)
# Add note about adding a puts when customizing to_s method



require 'pry'

# Blacjack is game where each player tries to have their hand of card face values equal (or be as close to 21 as possible)

# - The players are dealt two cards each
# - After looking at the sum of the cards, the human can decide to hit or stay
# - If the human player has not busted, then the computer will hit if their hand is worth less than 17
# - If neither player has busted, the two sum of the two hands will be compared. Which is greater wins.

# Nouns: game, player, hand, cards, deck
# Verbs: deal/hit, bust, sum

# Player
# - name
# - hit
# - stay
# - busted?
# - total

# Card
# - face values
# - sum

# Deck
# - deal

# Game
#  - start

# Tic Tac Toe is a two player board game.
# Each player is assigned a mark, can can make one mark per turn.
# The player with three marks in a row wins

# Nouns: player, board, mark, 
# Verbs: move

# Board
# Player
# - mark
# - move
# Game