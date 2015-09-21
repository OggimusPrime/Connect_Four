require_relative '../models/connect_four.rb'

class GameController
  attr_accessor :game

  def initialize
    @connect_four = ConnectFour.new
  end

  def game_menu
    puts 'How big would you like the board to be?'
    selection = gets.to_i

    @connect_four.board_size(selection)

    puts 'Player 1 is Red (R) & Player 2 is Blue (B)'

    play
  end

  def play
    player = @connect_four.player

    puts "Player #{player}: Which column would you like to place your chip in?"

    choice = gets.to_i
    @connect_four.insert_chip(choice)
    @connect_four.won
    # @connect_four.horizontal
    # @connect_four.verticle

    play
  end
end
