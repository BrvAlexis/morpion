class BoardCase
  attr_accessor :position, :value

  def initialize(position)
    @position = position #représente l'identifiant de la case (par exemple, "A1", "B2", etc.).
    @value = " " # représente le contenu de la case, qui peut être "X", "O", ou une chaîne vide indiquant que la case est initialement vide.
  end
end

