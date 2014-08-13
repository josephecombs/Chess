# require './sliding_piece.rb'

class Rook < SlidingPiece
  attr_accessor :string_representation, :color
  def initialize(board, color, coordinates)
    @string_representation = "R"
    @color = color
  end

  def move_dirs
    [:line]
  end
  
  
  
end