# require './board.rb'

class Piece
  attr_accessor :coordinates, :board, :color, :string_representation, :legal_moves
  
  def initialize(board, color, coordinates)
    @board = board
    @color = color
    @coordinates = coordinates
    @legal_moves = []
  end
  
  def to_s
    @string_representation
  end
  
  def color
    @color
  end

  def inside_bounds?(coord)
    # p coord
    coord.first.between?(0, 7) && coord.last.between?(0, 7)
  end
  
  # def update_view
  #   legal_moves_array = []
  #
  #   self.offsets.each do |coord|
  #     # p coord
  #     # p "here's what goes into legal_moves_array: #{[(coordinates[0] + coord[0]), (coordinates[1] + coord[1])]}"
  #     legal_moves_array << [(coordinates[0] + coord[0]), (coordinates[1] + coord[1])]
  #   end
  #
  #   legal_moves_array = legal_moves_array.delete_if { |coord| !inside_bounds?(coord) }
  #   # p "Here's the legal moves array after bounds filtering"
  #   # p legal_moves_array
  #   same_color = legal_moves_array.reject do |coord|
  #     @board.tiles[coord[0]][coord[1]].nil?
  #   end.select do |coord|
  #     @board.tiles[coord[0]][coord[1]].color == self.color
  #   end
  #   # p "Here's the new legal moves array after filtering"
  #   # p (legal_moves_array - same_color)
  #   p "pre"
  #   p @legal_moves
  #   p legal_moves_array
  #   p same_color
  #   @legal_moves = (legal_moves_array - same_color)
  #   p "post"
  #   p @legal_moves
  #   #(legal_moves_array - same_color)
  # end

end
