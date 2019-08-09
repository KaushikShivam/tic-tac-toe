#!/usr/bin/env ruby

require '../lib/user_interface'
require '../lib/game'
require '../lib/player'

puts "Welcome to Tic-Tac-Toe"

game = Game.new

puts game.get_matrix
puts "To play, Please provide the following inputs"
#Validating user inputs 
input = nil
until input == "x" || input == "o"
  puts "Please enter either x or o"
  input = gets.chomp.downcase
end
puts "You've selected: #{input.upcase}"

# Initialise the players
player_1 = Player.new(input)
player_2 = Player.new((input == "x") ? "o" : "x")

game.players.push(player_1, player_2)

game_running = true
puts game.active_player

while game_running
  puts "(player#{game.active_player + 1}) Input a number from 1-3 to select the row"
  row = gets.chomp.to_i
  puts "(player#{game.active_player + 1}) Input a number from 1-3 to select the column"
  column = gets.chomp.to_i
  
  game.update_matrix(row, column)
  
  puts game.get_matrix
  
end