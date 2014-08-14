# require './piece.rb'

class Pawn < Piece
  attr_accessor :string_representation, :color, :board, :coordinates
  def initialize(board, color, coordinates)
    @string_representation = "p"
    @color = color
    @board = board
    @coordinates = coordinates
  end
  
  # TODO: Break into helper methods
  def update_view
    end_offsets = []
    color_sign = ((@color == :black) ? -1 : 1)
    
    end_offsets = []
      
    @legal_moves = end_offsets
    if color == :black
      if @coordinates.first == 6
        end_offsets << [5, @coordinates.last]
        end_offsets << [4, @coordinates.last]
      else
        end_offsets << [@coordinates.first + color_sign, @coordinates.last] unless @board.tiles[@coordinates.first + color_sign, @coordinates.last] 
      end
    else
      if @coordinates.first == 1
        end_offsets << [2, @coordinates.last]
        end_offsets << [3, @coordinates.last]
      else
        end_offsets << [@coordinates.first + color_sign, @coordinates.last] unless @board.tiles[@coordinates.first + color_sign, @coordinates.last]
      end
    end
    # p "updateview"
    # p @board
    # p @coordinates.last + 1
    # # p @board.tiles[1,0]
    # p @board.tiles[@coordinates.first - 1][@coordinates.last + 1]
    
    if inside_bounds?([@coordinates.first + color_sign, @coordinates.last - 1])
      left_corner = @board.tiles[@coordinates.first + color_sign][@coordinates.last - 1]
      if (!left_corner.nil? && left_corner.color != color)
        end_offsets << left_corner.coordinates
      end
    end

    if inside_bounds?([@coordinates.first + color_sign, @coordinates.last + 1])
      # p [@coordinates.first + color_sign, @coordinates.last + 1]
      # if !@board.tiles[@coordinates.first + color_sign, @coordinates.last + 1].nil?
      
        # p "right corner: #{@board.tiles[@coordinates.first + color_sign][@coordinates.last + 1]}"
        right_corner = @board.tiles[@coordinates.first + color_sign][@coordinates.last + 1]
        if (!right_corner.nil? && right_corner.color != color)
          end_offsets << right_corner.coordinates
        end
    end
    @legal_moves = end_offsets
    
  end
  
end