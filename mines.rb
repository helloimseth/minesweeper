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

  end

end



class Tile

  DELTAS #constant of move locations 

  def initialize
    @neighbors = #store local nodes
    @flagged = false
    @bomb #finish this
    @pos #finish this
    @board #pass board
  end

  def

  def receive_board_input

  end

  def flag_as_bomb

  end


  def reveal
    #count local bombs
  end


end


class Player


end



class Game


end



class Load


end
