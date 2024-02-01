require 'bundler'
Bundler.require

require_relative('lib/player.rb')
require_relative('lib/board.rb')

require_relative('lib/game.rb')
require_relative('lib/show.rb')




class Application
  def perform
    puts "Bienvenue dans le jeu de morpion !"

    while true
      game = Game.new
      game.turn
      break unless play_again?
    end

    puts "Merci d'avoir joué !"
  end

 

  def play_again?
    puts "Voulez-vous jouer une nouvelle partie ? (O/N)"
    choice = gets.chomp.upcase
    choice == 'O'
  end
end



 Application.new.perform








