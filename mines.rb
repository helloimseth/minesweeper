require 'terminfo'
require 'yaml'

class Board
  attr_reader :board, :num_bombs, :height, :width, :loss; :date

  def initialize(height = 9, width = 9, num_bombs = 10)
    @height = height
    @width = width
    make_empty_board(height, width)
    add_bombs(num_bombs)
    link_tiles
    @num_bombs = num_bombs
    @loss = false
    @date = Time.now
  end

  def game_over?
    @loss || win?
  end

  def win?
    self.each_tile { |tile| return false if !tile.bomb && !tile.revealed }
    true
  end

  def render
    rendered_rows = []

    @board.each_with_index do |row, index|
      rendered_rows << [(index + 97).chr, "|", row.map{ |tile| tile.render(@loss)}].join(" ")
    end

    rendered_rows << [" " * 3].concat(Array.new(height, "-")).join(" ")
    rendered_rows << [" " * 3].concat((0...width).to_a).join(" ")

    rendered_rows
  end

  def display
    render.each { |line| puts line.center(TermInfo.screen_size[1]) }
  end

  def parse_input(string)
    args = string.split(" ")
    pos = args.select {|val| /[0-9]/ =~ val}
    args.delete(pos)
    call = args.first.to_sym
    y, x = parse_pos(pos)

    call == :flag ? self[y, x].flag : self[y, x].reveal
    display
  end

  def parse_pos(pos)
    coords = pos.first.split("").sort
    [(coords[1].upcase.ord - 65), coords[0].to_i]
  end

  def trigger_loss
    @loss = true
  end

  def tile(y,x)
    @board[y][x]
  end

  def each_tile(&prc)
    @board.each do |row|
      row.each do |tile|
        prc.call(tile)
      end
    end
  end

  def [](y,x)
    @board[y][x]
  end

  def []=(pos, value) #may want to delete this later
    y, x = pos
    @board[y][x] = value
  end

  def make_empty_board(height, width)
    @board = Array.new(height) { Array.new(width) }

    @board.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        @board[y][x] = Tile.new([y, x], self)
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

  def link_tiles
    self.each_tile {|tile| tile.add_neighbors(@board)}
    count_bombs
  end

  def count_bombs
    self.each_tile(&:count_neighbor_bombs)
  end
end


class Tile
  attr_reader :neighbors, :bomb, :neighbor_bomb_count, :flagged, :revealed

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
    @neighbors = []
  end

  def inspect
    "Pos: #{@pos}\nBomb?: #{@bomb}\nFlagged? #{@flagged}\nRevealed? #{@revealed}\nNBC: #{neighbor_bomb_count}"
  end

  def make_bomb
    @bomb = true
  end

  def flag
    @flagged = !@flagged
  end

  def add_neighbor(neighbor)
    @neighbors << neighbor
    neighbor.neighbors << self
  end

  def add_neighbors(board)
    DELTAS.each do |(dy, dx)|
      current_y, current_x = @pos
      new_y, new_x = current_y + dy, current_x + dx

      next unless new_y.between?(0, @board.height - 1) &&
                  new_x.between?(0, @board.width  - 1)

      neighbor = @board[new_y, new_x]
      add_neighbor(neighbor) unless @neighbors.include?(neighbor)
    end
  end

  def render(game_over)
    if game_over && bomb
      "B"
    elsif @revealed
      @neighbor_bomb_count == 0 ? "~" : @neighbor_bomb_count
    elsif @flagged
      "F"
    else
      "*"
    end
  end


  def reveal
    if @bomb
      @board.trigger_loss
      return nil
    end

    @revealed = true
    if @neighbor_bomb_count == 0
      @neighbors.each do |neighbor|
        next if neighbor.flagged || neighbor.revealed
        neighbor.reveal
      end
    end

    nil
  end

  def count_neighbor_bombs
    @neighbor_bomb_count = 0
    @neighbors.each {|neighbor| @neighbor_bomb_count += 1 if neighbor.bomb}
    nil
  end

end


class Game

  def initialize(board = nil)
    @board = board || Board.new
  end

  def self.display_saves(saves)
    saves.each_with_index do |save, index|
      puts "#{index}. #{save.date}"
    end
  end

  def self.display_start_menu
    display_header
    puts "Do you want to load a game? y/n"
    input = gets.chomp
    if input.upcase == "Y"
      display_saves(load_saves)
    else
      Game.new.play
    end
  end

  def self.load_saves
    saves = []
    yaml_files = File.readlines('saves.txt').map(&:chomp)
    yaml_files.each do |filename|
      saves << YAML::load(filename)
    end
    saves
  end

  def play
    until @board.game_over?
      display_board
      @board.parse_input(get_input)
    end

    display_outcome
  end

  def display_board
    self.class.display_header
    @board.display
    2.times { puts "" }
  end

  def self.display_header
    puts "\e[H\e[2J"
    puts "---*~*~*~*~ MINESWEEPER ~*~*~*~*---".center(TermInfo.screen_size[1])
    2.times { puts "" }
  end

  def get_input
    print ("What move would you like to make:  ").rjust(38)
    gets.chomp
  end

  def display_outcome
    display_board
    if @board.win?
      puts "You win! It took #{nil} seconds..."
    else
      puts "Sorry, you lost and wasted #{nil} seconds..."
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  Game.display_start_menu
end
