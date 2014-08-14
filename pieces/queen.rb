# require './sliding_piece.rb'

class Queen < SlidingPiece
  attr_accessor :string_representation, :color, :board, :coordinates
  def initialize(board, color, coordinates)
    @string_representation = "Q"
    @color = color
    @board = board
    @coordinates = coordinates
  end

  def offsets
    diagonal_offsets + line_offsets
  end
  
  
end