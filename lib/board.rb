class Board
    attr_accessor :board_cases, :count_turn
  
    def initialize
      # Créer un tableau (3x3) de BoardCases et les stocker dans l'attribut board_cases
      @board_cases = Array.new(3) { Array.new(3) { BoardCase.new } }
      # Initialiser le compteur de coups à 0
      @count_turn = 0
    end
  
    def display
      puts "   1   2   3"
      puts " -------------"
      @board_cases.each_with_index do |row, i|
        print "#{i + 1} |"
        row.each do |cell|
          print " #{cell.value} |"
        end
        puts "\n -------------"
      end
    end
  
    def play_turn(player)
      # Demander au joueur ce qu'il souhaite faire
      puts "#{player.name}, c'est à toi de jouer !"
      puts "Choisis une case (par exemple, 1,2 pour la première ligne deuxième colonne): "
      choice = gets.chomp.split(",").map(&:to_i)
  
      # Vérifier si la case est valide et non occupée
      if valid_move?(choice)
        row, col = choice
        @board_cases[row - 1][col - 1].value = player.symbol
        @count_turn += 1
      else
        puts "Case invalide. Veuillez choisir une case valide."
        play_turn(player)
      end
    end
  
    def valid_move?(choice)
      row, col = choice
      row.between?(1, 3) && col.between?(1, 3) && @board_cases[row - 1][col - 1].value == " "
    end
  
    def victory?
      # Vérifier les lignes, colonnes et diagonales pour une victoire
      return true if check_lines || check_columns || check_diagonals
  
      # Vérifier s'il y a un match nul
      return true if @count_turn == 9
  
      false
    end
  
    private
  
    def check_lines
      @board_cases.each do |row|
        return true if row.map(&:value).uniq.length == 1 && row[0].value != " "
      end
      false
    end
  
    def check_columns
      @board_cases.transpose.each do |col|
        return true if col.map(&:value).uniq.length == 1 && col[0].value != " "
      end
      false
    end
  
    def check_diagonals
      diagonal1 = [@board_cases[0][0].value, @board_cases[1][1].value, @board_cases[2][2].value].uniq.length == 1 && @board_cases[1][1].value != " "
      diagonal2 = [@board_cases[0][2].value, @board_cases[1][1].value, @board_cases[2][0].value].uniq.length == 1 && @board_cases[1][1].value != " "
      diagonal1 || diagonal2
    end
end
  