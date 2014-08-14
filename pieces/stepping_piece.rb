# require './piece.rb'

class SteppingPiece < Piece

  def update_view
    legal_moves_array = []
    
    self.offsets.each do |coord|
      legal_moves_array << [(coordinates[0] + coord[0]), (coordinates[1] + coord[1])]
    end

    legal_moves_array = legal_moves_array.delete_if { |coord| !inside_bounds?(coord) }
    # p "Here's the legal moves array after bounds filtering"
    # p legal_moves_array
    same_color = legal_moves_array.reject do |coord|
      @board.tiles[coord[0]][coord[1]].nil?
    end.select do |coord|
      @board.tiles[coord[0]][coord[1]].color == self.color
    end
    # p "Here's the new legal moves array after filtering"
    # p (legal_moves_array - same_color)

    @legal_moves = (legal_moves_array - same_color)

    #(legal_moves_array - same_color)
  end
end