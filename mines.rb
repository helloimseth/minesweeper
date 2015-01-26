class Board

  def self.seed_board
    #take optional board size and bomb number arguments
    #going to have to create tile instances that will be in the master array
    #board creates tiles
    #tiles shake hands(being passed the board)
  end

  def initialize
    @board = self.class.seed_board
  end

  def render

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

  DELTAS #constant of move locations

  def initialize
    @neighbors = #store local nodes
    @flagged = false
    @bomb #finish this
    @pos #finish this
    @board #pass board
    @revealed = false
  end

  def inspect
    "Pos: #{@pos}\nBomb?: #{@bomb}\nFlagged? #{@flagged}\nRevealed? #{@revealed}\n
    Neighbor B.C. #{neighbor_bomb_count}"
  end

  def add_neighbor
    #add a single neighbor
  end

  def add_neighbors
    #loop that does all the deltas
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
