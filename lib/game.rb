require_relative('player.rb')
require_relative('board.rb')

class Game
    attr_accessor :current_player, :status, :board, :players
  
    def initialize
      # Demander le prénom du premier joueur
      puts "Joueur 1, quel est ton prénom ?"
      player1_name = gets.chomp
      player1 = Player.new(player1_name, "X")
  
      # Demander le prénom du deuxième joueur
      puts "Joueur 2, quel est ton prénom ?"
      player2_name = gets.chomp
      player2 = Player.new(player2_name, "O")
  
      # Initialiser le tableau des joueurs
      @players = [player1, player2]
  
      # Créer un nouveau plateau de jeu
      @board = Board.new
  
      # Initialiser le joueur courant
      @current_player = @players.first
  
      # Initialiser le statut du jeu à "en cours"
      @status = "en cours"
    end
  
    def turn
      # Afficher le plateau de jeu
      @board.display
  
      # Demander au joueur courant de jouer
      @board.play_turn(@current_player)
  
      # Vérifier s'il y a un vainqueur ou si la partie est nulle
      if @board.victory?
        @status = @current_player
      elsif @board.count_turn == 9
        @status = "match nul"
      else
        # Passer au joueur suivant si la partie n'est pas finie
        switch_player
      end
    end
  
    def new_round
      # Relancer une partie en initialisant un nouveau plateau de jeu
      @board = Board.new
      @status = "en cours"
    end
  
    def game_end
      # Afficher le plateau de jeu pour la dernière fois
      @board.display
  
      # Afficher le résultat de la partie
      if @status.is_a?(Player)
        puts "#{current_player.name} remporte la partie !"
      else
        puts "La partie se termine par un match nul."
      end
    end
  
    private
  
    def switch_player
      # Changer le joueur courant
      @current_player = (@current_player == @players.first) ? @players.last : @players.first
    end
  end
  