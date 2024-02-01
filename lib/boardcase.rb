class BoardCase
  attr_accessor :position, :value

  def initialize(position)
    @position = position
    @value = " " # La valeur par défaut est une chaîne vide, la case est initialement vide
  end
end

