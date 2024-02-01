require_relative('boardcase.rb')
require_relative('player.rb')


class Board
  attr_accessor :board_cases, :count_turn

  def initialize
    @board_cases = create_board_cases
    @count_turn = 0
  end

  def play_turn(player)
    puts "#{player.name}, c'est à toi de jouer !"
    display_board

    puts "Choisis une case (A1, B2, C3, etc.) : "
    chosen_position = gets.chomp.upcase

    if valid_move?(chosen_position)
      update_board_case(chosen_position, player.symbol)
      @count_turn += 1
    else
      puts "Case invalide. Choisis une case non occupée."
      play_turn(player)
    end
  end

  def victory?
    # Méthode qui vérifie le plateau et indique s'il y a un vainqueur ou match nul
    # (à implémenter selon les règles du morpion)
  end

  

  def create_board_cases
    # Crée les 9 instances de BoardCase avec des positions uniques
    board_cases = {}
    ('A'..'C').each do |row|
      (1..3).each do |col|
        position = "#{row}#{col}"
        board_cases[position] = BoardCase.new(position)
      end
    end
    board_cases
  end

  def display_board
    # Affiche le plateau de jeu
    puts "-----"
    ('A'..'C').each do |row|
      (1..3).each do |col|
        position = "#{row}#{col}"
        print "| #{board_cases[position].value} "
      end
      puts "|"
      puts "-----"
    end
  end

  def valid_move?(position)
    # Vérifie si la case choisie est valide (non occupée)
    @board_cases[position].value == " "
  end

  def update_board_case(position, value)
    # Met à jour la valeur de la case choisie par le joueur
    @board_cases[position].value = value
  end

  def full_board?
    @count_turn == 9
  end
  
end
