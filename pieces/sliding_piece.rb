# require_relative './piece.rb'

class SlidingPiece < Piece

  def diagonal_offsets
    diags = [[1,1], [-1,1], [-1,-1], [1,-1]]
    generate_offset_vectors diags
  end

  def line_offsets
    lines = [[0,1],[-1,0],[0,-1],[1,0]]
    generate_offset_vectors lines
  end

  def generate_offset_vectors(dirs)
    offsets = dirs.map do |offset|
      (1..7).to_a.map do |multiplier| 
        [offset.first * multiplier, offset.last * multiplier]
      end
    end
    offsets
  end

  def update_view
    grand_offsets = offsets
    grand_offsets.each do |row|
      row.map! do |offset|
        (offset.zip(@coordinates)).map { |el| el.first + el.last }
      end
    end
    temp_positions = grand_offsets
    temp_positions.map!{|ray| ray.select{ |pos| inside_bounds?(pos) } }
    end_offsets = []
  
    grand_offsets.each do |ray|
      ray.each do |coord|
        if @board[coord].nil?
          #shovel always if you hit a nil square
          end_offsets << coord
        else #square is occupied
          #p "square is occupied"
          if @board[coord].color != self.color #by enemy
            end_offsets << coord
          end
          #cannot continue adding from ray
          break
        end
      end
    end
        
    # p "end_offsets: #{end_offsets}, color: #{color}, position: #{coordinates}, class: #{self.class}"
    @legal_moves = end_offsets
    end_offsets
  end

end
