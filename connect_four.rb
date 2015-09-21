require_relative 'controllers/game_controller.rb'

game = GameController.new

system 'clear'
puts "Let's play connect four!"
game.game_menu
