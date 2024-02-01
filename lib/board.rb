require_relative('boardcase.rb')
require_relative('player.rb')


class Board
  attr_accessor :board_cases

  def initialize
    @board_cases = create_board_cases
    @count_turn = 0
  end

  def play_turn(player)
    display_board
    puts "#{player.name}, c'est à toi de jouer !"
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

  def check_lines
    ('A'..'C').any? do |row|
      values = (1..3).map { |col| @board_cases["#{row}#{col}"].value }
      puts "Line #{row}: #{values}"
      values.uniq.length == 1 && values.first != " "
    end
  end
  
  def check_columns
    (1..3).any? do |col|
      values = ('A'..'C').map { |row| @board_cases["#{row}#{col}"].value }
      puts "Column #{col}: #{values}"
      values.uniq.length == 1 && values.first != " "
    end
  end
  
  def check_diagonals
    diagonals_values = [
      ('A'..'C').map { |row| @board_cases["#{row}#{row}"]&.value },
      ('A'..'C').map { |row| @board_cases["#{row}#{4 - row.ord}"]&.value }
    ]
  
    diagonals_values.any? do |values|
      puts "Diagonal: #{values}"
      values&.compact&.uniq&.length == 1 && values&.first != " "
    end
  end
  
  
  def victory?
    # Vérification des lignes, colonnes et diagonales
    return true if check_lines || check_columns || check_diagonals

    false
  end

  def create_board_cases
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
    @board_cases[position].value == " "
  end

  def update_board_case(position, value)
    puts "Mise à jour de la case #{position} avec la valeur #{value}"
    @board_cases[position].value = value
  end


  def full_board?
    @count_turn == 9
  end
end
