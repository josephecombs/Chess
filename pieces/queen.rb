# require './sliding_piece.rb'

class Queen < SlidingPiece
  attr_accessor :string_representation, :color
  def initialize(board, color, coordinates)
    @string_representation = "Q"
    @color = color
  end

  def move_dirs
    [:line, :diagonal]
  end
  
  
end