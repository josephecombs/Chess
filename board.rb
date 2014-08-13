require './pieces.rb'

class Board
  attr_accessor :tiles
  
  def initialize
    @tiles = Array.new(8) { Array.new(8, nil) }
    generate_starting_tiles
    update_all_views
  end
  
  def [](coordinates)
    @tiles[coordinates]
  end
  
  def generate_starting_tiles
    @tiles[0] = generate_home_row(:white, 0)
    #@tiles[1] = generate_pawn_row(:white, 1)
    @tiles[1] = Array.new(8, nil)
    @tiles[6] = generate_pawn_row(:black, 6)
    @tiles[7] = generate_home_row(:black, 7)
  end
  
  def display_state
    (0..7).to_a.reverse.each do |row_i|
      row_array =[]
      @tiles[row_i].each do |tile|
        row_array << (tile.nil? ? " " : tile.to_s)
        # row_array << "X"
      end
      puts "#{row_i+1} " + row_array.join
    end
    puts "  abcdefgh"
  end
  
  def generate_pawn_row(color, row_num)
    pawn_row = Array.new(8) { |col_num| Pawn.new(@board, color, [row_num, col_num] ) }
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
    @tiles[coord2[0]][coord2[1]] = @tiles[coord1[0]][coord1[1]]
    @tiles[coord1[0]][coord1[1]] = nil
    @tiles[coord2[0]][coord2[1]].coordinates = coord2
  end
  
  def update_all_views
    @tiles.each do |row|
      row.each do |piece|
        p piece
        next if piece.nil?
        next unless (piece.is_a?(Knight) || piece.is_a?(King))
        piece.update_view
      end
    end
  end
end