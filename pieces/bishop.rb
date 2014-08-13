# require_relative 'sliding_piece.rb'

class Bishop < SlidingPiece
  attr_accessor :string_representation, :color
  def initialize(board, color, coordinates)
    @string_representation = "B"
    @color = color
  end
  
  def string_representation
    "B"
  end

  def move_dirs
    [:diagonal]
  end
  
  
  
end