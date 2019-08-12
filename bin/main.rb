#!/usr/bin/env ruby

require '../lib/user_interface'
require '../lib/game'
require '../lib/player'

def start_game
  puts 'Welcome to Tic-Tac-Toe'

  game = Game.new

  puts game.display_matrix
  puts 'To play, Please provide the following inputs'
  # Validating user inputs
  input = nil
  until input.eql?('x') || input.eql?('o')
    puts 'Please enter either x or o'
    input = gets.chomp.downcase
  end
  puts "You've selected: #{input.upcase}"

  # Initialise the players
  player_one = Player.new(input)
  player_two = Player.new(input == 'x' ? 'o' : 'x')

  game.players.push(player_one, player_two)
  until game.finished?
    puts "(player#{game.active_player + 1}) Input a number from 1-3 to select the row"
    row = nil
    while true
      row = gets.chomp
      break if ('1'..'3').include?(row)

      puts "(player#{game.active_player + 1}) Oops! You've made a mistake. Please enter a valid number between 1-3"
    end
    row = row.to_i

    puts "(player#{game.active_player + 1}) Input a number from 1-3 to select the column"
    column = nil
    while true
      column = gets.chomp
      break if ("1".."3").include?(column) 
      puts "(player#{game.active_player + 1}) Oops! You've made a mistake. Please enter a valid number between 1-3"
    end
    column = column.to_i

    unless game.update_matrix(row, column)
      puts "The cell you have selected is already used!".bg_red
      puts "Please select another cell."
    else
      game.handle_move
    end
    puts game.display_matrix

    if game.finished?
      if game.winner
        puts "Player #{game.winner + 1} Won!".bg_green
      else
        puts 'No one won!'.bg_blue
      end
    end
  end
end

while true
  start_game
  puts "Do you want to start another game ?[Y/N](default N)"
  answer = gets.chomp.downcase
  break if answer!="y" 
end