# require './sliding_piece.rb'

class Rook < SlidingPiece
  attr_accessor :string_representation, :color, :board, :coordinates
  def initialize(board, color, coordinates)
    @string_representation = "R"
    @color = color
    @board = board
    @coordinates = coordinates
  end

  def offsets
    line_offsets
  end
  
  
  
end