
require_relative('board.rb')
require_relative('player.rb')

class Game
  attr_accessor :current_player, :status, :board, :players

  def initialize
    @players = create_players
    @board = Board.new
    @status = "on going"
    @current_player = @players.first
  end

  def turn
    display_status
    @board.display_board
    @board.play_turn(@current_player)
    
    if @board.victory?
      @status = @current_player
      game_end
    elsif @board.full_board?
      @status = "draw"
      game_end
    else
      switch_current_player
      turn
    end
  end

  def new_round
    @board = Board.new
    @status = "on going"
    @current_player = @players.first
    turn
  end

  def game_end
    display_status

    case @status
    when Player
      puts "#{current_player.name} remporte la partie !"
    when "draw"
      puts "Match nul !"
    end

    puts "Voulez-vous faire une nouvelle partie ? (O/N)"
    choice = gets.chomp.upcase

    if choice == 'O'
      new_round
    else
      puts "Merci d'avoir joué !"
    end
  end

  private

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
    puts "Statut de la partie : #{@status}"
    puts "---------------"
  end
end
