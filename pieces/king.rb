# require './stepping_piece.rb'

class King < SteppingPiece
  attr_accessor :string_representation, :color
  def initialize(board, color, coordinates)
    @string_representation = "K"
    @color = color
    @coordinates = coordinates
    @board = board
  end
  
  def offsets
    [[ 1, 1],
     [ 0, 1],
     [-1, 1],
     [-1, 0],
     [-1,-1],
     [ 0,-1],
     [ 1,-1],
     [ 1, 0]]
  end

end