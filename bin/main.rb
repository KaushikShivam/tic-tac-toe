#!/usr/bin/env ruby

require '../lib/user_interface'
require '../lib/game'

puts "Welcome to Tic-Tac-Toe"

game = Game.new

game.matrix.length.times { |n| print "#{game.matrix[n].join(' ')}\n" }

