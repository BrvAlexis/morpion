require 'bundler'
Bundler.require

require_relative('lib/player.rb')
require_relative('lib/board.rb')
require_relative('lib/boardcase.rb')
require_relative('lib/game.rb')

# Demander le prénom du premier joueur
puts "Joueur 1, quel est ton prénom ?"
player1_name = gets.chomp
player1 = Player.new(player1_name)

# Demander le prénom du deuxième joueur
puts "Joueur 2, quel est ton prénom ?"
player2_name = gets.chomp
player2 = Player.new(player2_name)

# Afficher les prénoms des joueurs
puts "Les prénoms des joueurs sont :"
puts "Joueur 1 : #{player1.name}"
puts "Joueur 2 : #{player2.name}"

board = Board.new
board.display

game = Game.new

# Boucle de jeu
while game.status == "en cours"
  game.turn
end

# Afficher le résultat de la partie
game.game_end








