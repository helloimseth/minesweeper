class Board
  attr_reader :board, :num_bombs

  def initialize(height = 9, width = 9, num_bombs = 10)
    make_empty_board(height, width)
    add_bombs(num_bombs)
    shake_hands
    @num_bombs = num_bombs
  end

  def make_empty_board(height, width)
    @board = Array.new(height) { Array.new(width) }

    @board.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        @board[y][x] = Tile.new([y, x], @board)
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
    self.each_tile {|tile| tile.add_neighbors}
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

  private

  def each_tile(&prc)
    @board.each do |row|
      row.each do |tile|
        prc.call(tile)
      end
    end
  end

  def [](pos)
    y, x = pos
    @board[y][x]
  end

  def []=(pos, value)
    y, x = pos
    @board[y][x] = value
  end



end



class Tile
  attr_reader :neighbors, :bomb

  DELTAS = [
    [-1, -1], [-1, 0], [-1, 1],

    [0, -1],           [0, 1],

    [1, -1],  [1, 0],  [1, 1] ]


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
