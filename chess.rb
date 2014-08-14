require './pieces.rb'
require './board.rb'
# require './pieces/piece.rb'

class Chess
  #attr_accessor :board
  attr_reader :coordinate_hash
  attr_accessor :turn

  def initialize
    @coordinate_hash = generate_coordinate_hash
    @board = Board.new
  end
  
  def play_game
    over = false
    counter = 0
    until over
      current_turn_color = [:white, :black][counter % 2]
      counter += 1

      @board.display_state
      p "king coordinates: #{@board.find_king(:black)}"
      p "king coordinates: #{@board.find_king(:white)}"
      print "#{current_turn_color}: Please enter from move location and to move location as, ex., 'a2,a3': "
      
      args = get_input
      
      from_coord = process_input(args.first)
      #from_coord = process_input(args[0])
      to_coord = process_input(args.last)
      #to_coord = process_input(args[1])
      #p "from_coord #{from_coord}"
      #p "to_coord #{to_coord}"
      
      #dupe board and check its state after player makes a move
      dupe_board = @board.dup
       
      unless dupe_board.is_legal_move?(from_coord, to_coord)
        puts "Proposed move is illegal."
        next
      end
      
      #see what happens when you try to move as the player wishes
      dupe_board.move(from_coord, to_coord)
      dupe_board.update_all_views
      if dupe_board.is_in_check?(current_turn_color)
        puts "You have made a move that has placed your own king into check."
        next
      end
      
      @board.move(from_coord, to_coord)
      #update the legal_moves array for each tile on the board
      @board.update_all_views
      
      #this switches the color of the current turn so we can do some further board state checks
      current_turn_color = [:white, :black][counter % 2]
      if @board.is_in_check?(current_turn_color)
        puts "#{current_turn_color} King is in check!"
        if @board.is_in_checkmate?(current_turn_color)
          over = true
        end
      end
    end
  end
  
  private
  
  # def flip_color(color)
  #   ([:black, :white] - [color]).first
  # end
  
  def get_input
    input = gets.chomp.downcase.split(",")
    input
  end
  
  def process_input(chess_coordinate)
    @coordinate_hash[chess_coordinate]
  end
  
  def generate_coordinate_hash
    local_hash = {}
    ('a'..'h').to_a.each_with_index do |letter, i|
      (1..8).each do |number|
        local_hash[(letter + number.to_s)] = [(number - 1), i]
      end
    end
    local_hash
  end

end

a = Chess.new

# p a.coordinate_hash
a.play_game
