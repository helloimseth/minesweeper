class Board
  attr_reader :board, :num_bombs

  def initialize(height = 9, width = 9, num_bombs = 10)
    make_empty_board(height, width)
    add_bombs(num_bombs)
    @num_bombs = num_bombs
  end

  def make_empty_board(height, width)
    @board = Array.new(height) { Array.new(width) }

    @board.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        @board[x][y] = Tile.new([x, y], @board)
      end
    end
  end

  def add_bombs(num_bombs)
    bombs_added = 0
    until bombs_added >= num_bombs
      rand_row = @board.sample
      rand_tile = rand_row.sample
      bombs_added += 1 unless rand_tile.bomb
      rand_tile.make_bomb
    end
  end

  def shake_hands

  end

  def render

  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @board[x][y] = value
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
  attr_reader :neighbors, :bomb

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
