# require_relative 'sliding_piece.rb'

class Bishop < SlidingPiece
  attr_accessor :string_representation, :color, :board, :coordinates
  def initialize(board, color, coordinates)
    @string_representation = "B"
    @color = color
    @board = board
    @coordinates = coordinates
  end
  
  def string_representation
    "B"
  end

  def offsets
    diagonal_offsets
  end
  
  
  
end