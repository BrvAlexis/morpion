
require_relative('board.rb')
require_relative('player.rb')

class Game
  attr_accessor :current_player, :status, :board, :players

  def initialize
    @players = create_players
    @board = Board.new
    @status = "Début de partie !"
    @current_player = @players.first
  end

  def turn
    display_status
    @board.display_board
    @board.play_turn(@current_player)

    if @board.victory?
      puts "Victoire détectée !"
      @status = @current_player
      game_end
    elsif @board.full_board?
      puts "Match nul détecté !"
      @status = "draw"
      game_end
    else
      switch_current_player
      turn
    end
  end


  def new_round
    @board = Board.new
    @status = "A t-on tour !"
    @current_player = @players.first
    turn
  end

  def game_end
    if @board.victory?
      puts "#{current_player.name} remporte la partie !"
    else
      puts "La partie est un match nul."
    end
  end

  

  def create_players
    puts "Entrez le nom du joueur 1 :"
    name1 = gets.chomp
    player1 = Player.new(name1, "X")

    puts "Entrez le nom du joueur 2 :"
    name2 = gets.chomp
    player2 = Player.new(name2, "O")

    [player1, player2]
  end

  def switch_current_player
    @current_player = (@current_player == @players.first) ? @players.last : @players.first
  end

  def display_status
    puts "---------------"
    puts "#{@status}"
    puts "---------------"
  end
end
