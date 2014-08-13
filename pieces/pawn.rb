# require './piece.rb'

class Pawn < Piece
  attr_accessor :string_representation, :color
  def initialize(board, color, coordinates)
    @string_representation = "p"
    @color = color
  end
  
  def update_view
  end
  
  
end