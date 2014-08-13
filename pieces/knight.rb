# require './stepping_piece.rb'

class Knight < SteppingPiece
  attr_accessor :string_representation
  attr_reader :color
  def initialize(board, color, coordinates)
    @string_representation = "n"
    @color = color
    @coordinates = coordinates
    @board = board
  end
  
  def offsets
    [[ 2, 1],
     [ 2,-1],
     [-2, 1],
     [-2,-1],
     [ 1, 2],
     [ 1,-2],
     [-1, 2],
     [-1,-2]]
  end
  
  # def view
  #   legal_moves_array = []
  #
  #   legal_moves_array << [(@coordinates[0] + 2), (@coordinates[1] + 1)]
  #   legal_moves_array << [(@coordinates[0] + 2), (@coordinates[1] - 1)]
  #   legal_moves_array << [(@coordinates[0] - 2), (@coordinates[1] + 1)]
  #   legal_moves_array << [(@coordinates[0] - 2), (@coordinates[1] - 1)]
  #   legal_moves_array << [(@coordinates[0] + 1), (@coordinates[1] + 2)]
  #   legal_moves_array << [(@coordinates[0] + 1), (@coordinates[1] - 2)]
  #   legal_moves_array << [(@coordinates[0] - 1), (@coordinates[1] + 2)]
  #   legal_moves_array << [(@coordinates[0] - 1), (@coordinates[1] - 2)]
  #
  #   legal_moves_array = legal_moves_array.delete_if { |coord| !inside_bounds?(coord) }
  #
  #   same_color = legal_moves_array.reject do |coord|
  #     @board.tiles[coord[0]][coord[1]].nil?
  #   end.select do |coord|
  #     @board.tiles[coord[0]][coord[1]].color == self.color
  #   end
  #
  #   (legal_moves_array - same_color)
  # end
end