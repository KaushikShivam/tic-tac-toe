# tic-tac-toe

A game of Tic-Tac-Toe using ruby language. The game of played using the command line

## Game Rules

Please follow the listed down rules to play the game of Tic-Tac-Toe

1. The game starts with asking the Player 1 to input his preferred choice of Symbol **_( X or O )_** . A symbol is then assigned to Player 1 and the opposite symbol to Player 2

2. The game starts once the Player 1 has picked the symbol. He is asked to enter a number between **_1 - 3_** for the **_ROW_**

3. Then the player 1 is asked to enter a number between **_1 - 3_** for the **_Column_**

4. The game then plots the player's chosen cell using the provided row and column input.

5. Then, the game switches on to player 2 for his input and so on.

6. The game ends if:

- A user is able to plot an entire Row / Column
- A user is able to plot a diagonal line (Left/Right)
- The moves are equal to 9 -> In this case, No one wins

## Testing
This project has been updated to add tests for the Game & Player class using RSpec
### documentation for the tests:
```
Game
  #check_move
    should return true if either of the methods return true
    should return false if niether of the methods return true
  #check_diagonal
    should return true if the slots match diagonaly from left
    should return true if slots match diagonaly from right
    should return false if the slots don't match diagonaly
  #check_vertical
    should return true if the slots match vertically from first column
    should return true if the slots match vertically from second column
    should return true if the slots match vertically from third column
    should return false if slots don't match vertically
  #check_horizontal
    should return true if the slots match horizontally from first row
    should return true if the slots match horizontally from second row
    should return true if the slots match horizontally from third row
    should return false if slots don't match horizontally from any row
  #finished?
    should not return false if the winner is not nil or if drawn is true
    should not return false if the winner is 1 & drawn is false
    should return false if the winner is nil & if drawn is false
    should return true if the winner is nil & drawn is true
  #drawn?
    should return true if the move counter is equal to 9
    should return false if the move counter is smaller than 9
  #slot_taken?
    should return false if no slot is taken
    should return true if a slot is taken
  #handle_move
    should update the winner if check_move return true
    should change the active player if check_move return false
  #update_matrix
    should return false if slot_taken? returns true
    should return true if slot_taken? returns false
    should increment count if slot_taken? returns false
    should update matrix if slot_taken? returns false
  #find_active_player
    should return the active player object
  #switch_active_player
    should switch the active player object
  #display_matrix
    should return the matrix as a string
  #initialize
    should return a matrix variable
    should return an empty players array
    should set 0 for the active player
    should set 0 for the counter
    should set winner to nil

Player
  should create a Player object with a symbol x
  should create a Player object with a symbol o
  should raise ArgumentError if no argument is given
```
