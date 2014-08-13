# require_relative './piece.rb'

class SlidingPiece < Piece

  def populate_diagonal_offsets
    offsets = Array.new (4) { Array.new }
    
    [[1,1], [-1,1], [-1,-1], [1,-1]].each_with_index do |offset, i|
      1.upto(7) { |j| offsets[i] << offset.map{|o| o * j } }
    end
    
    offsets
  end
  
  def populate_line_offsets
    offsets = Array.new (4) { Array.new }
    
    [[0,1],[-1,0],[0,-1],[1,0]].each_with_index do |offset, i|
      1.upto(7) { |j| offsets[i] << offset.map{|o| o*j} }
    end
    
    offsets
    
  end
  
  def update_view
    grand_offsets = []
    if move_dirs.include?(:line)
       grand_offsets.concat(populate_line_offsets) 
    end
    
    if move_dirs.include?(:diagonal)
       grand_offsets.concat(populate_diagonal_offsets) 
    end
    
    #filter out of bounds coordinates from each ray
    grand_offsets.each do |ray|
      ray.delete_if { |coord| !inside_bounds?(coord) }
    end
    
    end_offsets = []
    
    grand_offsets.each do |ray|
      jump = false
      next if jump
      ray.each do |coord|
        
        if @board.tiles[coord[0]][coord[1]].nil?
          #shovel always if you hit a nil square
          end_offsets << [coord[0]][coord[1]]
        else
          #this is the case where an opponent's piece is hit
          if @board.tiles[coord[0]][coord[1]].color != self.color
            end_offsets << [coord[0]][coord[1]]
            jump = true
          else #this is the case when your own piece is hit
            jump = true
          end
        end
      end
    end
    
    legal_moves_array = []
    
    grand_offsets.each do |ray|
      
      
      legal_moves_array << [(coordinates[0] + coord[0]), (coordinates[1] + coord[1])]
    end
    
    
    end_offsets
    
  end
  
end
