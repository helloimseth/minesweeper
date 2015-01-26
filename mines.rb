class Board

  def self.seed_board(height, width, num_bombs)
    #take optional board size and bomb number arguments
    #going to have to create tile instances that will be in the master array
    #board creates tiles
    #tiles shake hands(being passed the board)

    board = Array.new(height) { Array.new(width) }

    board.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        board[x][y] = [x, y]
      end
    end
  end

  def initialize
    @board = self.class.seed_board
  end

  def render

  end

  def [](pos)
  end

  def []=(pos, value)
  end

  def display

  end

  def pass_input_to_tile
    #could call reveal
  end

  def reveal_board_on_game_over

  end

end



class Tile
  attr_reader :neighbors

  DELTAS = []#constant of move locations

  def initialize(pos, board)
    @flagged = false
    @bomb = false
    @pos = pos
    @board = board
    @revealed = false
  end

  def inspect
    "Pos: #{@pos}\nBomb?: #{@bomb}\nFlagged? #{@flagged}\nRevealed? #{@revealed}\nNBC: #{neighbor_bomb_count}"
  end

  def make_bomb
    @bomb = true
  end

  def add_neighbor
    #add a single neighbor
  end

  def add_neighbors
    @neighbors#loop that does all the deltas
  end

  def receive_board_input

  end

  def flag_as_bomb
    @flagged = !@flagged
  end


  def reveal
    #count local bombs
  end

  def neighbor_bomb_count
    nil
  end


end


class Player

  def initialize

  end

  def get_input
  # either reveal or flag and a position
  end
end



class Game

  def initialize

  end

  def play
  #get input, and handle the input
  #we'll need an input loop to continue getting player input
  end

end



class Load


end
