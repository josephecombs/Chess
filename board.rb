require './pieces.rb'

class Board
  attr_accessor :tiles
  
  def initialize
    @tiles = Array.new(8) { Array.new(8, nil) }
    generate_starting_tiles
    update_all_views
  end
  
  def dup
    new_board = Board.new

    @tiles.each do |row|
      row.each do |piece|
        next if piece.nil?
        p piece
        piece.class.new(new_board, piece.color, piece.coordinates)
        p piece
      end
    end

    new_board
  end
  
  def [](coordinates)
    #coordinates => [4,5]
    @tiles[coordinates.first][coordinates.last]
  end
  
  def generate_starting_tiles
    @tiles[0] = generate_home_row(:white, 0)
    # @tiles[1] = generate_pawn_row(:white, 1)
    # @tiles[1] = Array.new(8, nil)
    # @tiles[4][4] = Pawn.new(self, :black, [4, 4])
    # @tiles[6] = generate_pawn_row(:black, 6)
    # @tiles[7] = generate_home_row(:black, 7)
    @tiles[7][6] = King.new(self, :black, [7, 6])
  end
  
  def display_state
    (0..7).to_a.reverse.each do |row_i|
      row_array =[]
      @tiles[row_i].each do |tile|
        row_array << (tile.nil? ? " " : tile.to_s)
      end
      puts "#{row_i+1} " + row_array.join
    end
    puts "  abcdefgh"
  end
  
  def generate_pawn_row(color, row_num)
    pawn_row = Array.new(8) { |col_num| Pawn.new(self, color, [row_num, col_num] ) }
    pawn_row
  end
  
  def generate_home_row(color, row_num)
    home_row = []
    
    # (0..7).each do |col_num|
    #   home_row << Rook.new(self, color, [col_num, row_num])
    # end
    home_row << Rook.new(self, color, [row_num, 0])
    home_row << Knight.new(self, color, [row_num, 1])
    home_row << Bishop.new(self, color, [row_num, 2])
    home_row << Queen.new(self, color, [row_num, 3])
    home_row << King.new(self, color, [row_num, 4])
    home_row << Bishop.new(self, color, [row_num, 5])
    home_row << Knight.new(self, color, [row_num, 6])
    home_row << Rook.new(self, color, [row_num, 7])
    home_row
  end
  
  def is_legal_move?(coord1, coord2)
    return false if @tiles[coord1[0]][coord1[1]].nil?
    return false unless @tiles[(coord1[0])][(coord1[1])].legal_moves.include?(coord2)
    true
  end
  
  def move(coord1, coord2)
    # p "@tiles[coord1[0]][coord1[1]].legal_moves #{@tiles[coord1[0]][coord1[1]].legal_moves}"
    @tiles[coord2[0]][coord2[1]] = @tiles[coord1[0]][coord1[1]]
    @tiles[coord1[0]][coord1[1]] = nil
    @tiles[coord2[0]][coord2[1]].coordinates = coord2
  end
  
  def move_2(coord1, coord2, board)
    # p "@tiles[coord1[0]][coord1[1]].legal_moves #{@tiles[coord1[0]][coord1[1]].legal_moves}"
    board.tiles[coord2[0], coord2[1]] = board.tiles[coord1[0], coord1[1]]
    board.tiles[coord1[0], coord1[1]] = nil
    p "piece before failure #{board.tiles[coord2[0], coord2[1]]}"
    board.tiles[coord2[0], coord2[1]].coordinates = coord2 if board.tiles[coord2[0], coord2[1]].compact.count > 0
    board
  end
  
  def update_all_views
    @tiles.each do |row|
      row.each do |piece|
        #p piece.class
        next if piece.nil?
        # next unless (piece.is_a?(Rook) || piece.is_a?(Queen) || piece.is_a?(Bishop) || piece.is_a?(Knight) || piece.is_a?(King) || piece.is_a?(Pawn))
        #next unless (piece.is_a?(Knight) || piece.is_a?(King) || piece.is_a?(Queen) || piece.is_a?(Rook))
        piece.update_view
      end
    end
  end
  
  def find_king(color)
    tiles.each do |row|
      row.each do |piece|
        next if piece.nil?
        return piece.coordinates if piece.is_a?(King) && piece.color == color
      end
    end
  end
  
  def is_in_check?(color)
    tiles.flatten.compact.each do |piece|     
      return true if piece.legal_moves.include?(find_king(color))
    end
    false
  end
  
  def is_in_checkmate?(color)
    #dupe board and iterate through each given color piece's legal moves
    first_dup = self.dup
    p "first dup #{first_dup}"
    p "fits dup.tiles#{first_dup.tiles}"
    p "self #{self}"
    some_symbol = color
    first_dup.tiles.each do |row|
      p row
      row.each do |piece|
        next if piece.nil?
        next if piece.color != some_symbol
        
        #dupe board again so you dont mess up what you're iterating thru
        second_dup = first_dup.dup
        #get from_coordinates
        from_coordinates = piece.coordinates
        p "from coordinates #{from_coordinates}"
        piece.legal_moves.each do |coord|
          next if coord.nil?
          second_dup = second_dup.move_2(from_coordinates, coord, second_dup)
          second_dup.update_all_views
          return false if !second_dup.is_in_check?(color)
        end
      end
    end
    "The game is over! #{color} has been checkmated!"
    return true
  end
end