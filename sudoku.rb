require_relative "board"

# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        pos = parse_pos(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        pos = nil
      end
    end
    pos
  end

  def get_value
    value = nil
    until value && valid_value?(value)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      value = parse_value(gets.chomp)
    end
    value
  end

  def parse_pos(string)
    string.split(",").map { |char| Integer(char) }
  end

  def parse_value(string)
    Integer(string)
  end

  def play_turn
    board.render
    place_tile(get_pos, get_value)
  end

  def place_tile(pos, value)
    board[pos] = value
  end

  def run
    play_turn until game_over?
    puts "Congratulations, you win!"
  end

  def game_over?
    board.terminate?
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def valid_value?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.run
