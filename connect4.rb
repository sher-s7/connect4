require 'matrix'
require './player'
require 'colorize'
class String
  def is_integer?
    self.to_i.to_s == self
  end
end

class Connect4
  attr_accessor :board, :num_rows, :num_columnns, :columns

  def self.num_rows
    @@num_rows
  end
  def self.num_columns
    @@num_columnns
  end

  @@num_rows=6
  @@num_columnns=7

  def initialize
    @board = makeBoard
    @columns = []
    @@num_columnns.times do |num|
      @columns.push("#{num}")
    end
  end


  def makeBoard
    arr = []
    @@num_rows.times do
      arr.push([])
      @@num_columnns.times do
        arr.last.push(" ") #Placeholder for empty spaces
      end
    end
    return arr
  end

  def addPiece(piece, column)
    column = column.to_i
    (0..5).each do |row|
      if row == 5
        board[row][column] = piece
        return 
      elsif board[row+1][column] != " " && board[row][column] == " "
        board[row][column] = piece
        return
      end
    end
  end

  def getMove
    puts 'Enter a column number to place your piece: '
    begin
      move = gets.chomp
      if !(move.is_integer? && move.to_i.between?(0,6))
        raise 'Error: Enter the proper move format (a column number from 0-6)'
      elsif board[0][move.to_i] != " "
        raise 'Error: This column is full, choose another'
      end
    rescue Exception=>e
      puts e 
      retry
    end
    move
  end

  def swapTurn(currentTurn, p1, p2)
    return currentTurn == p1 ? p2 : p1
  end

  def rows_win?(piece, board = @board)
    board.each do |row|
      a=row.each_cons(4).find {|p| p.uniq.size == 1 && p.first != ' '}
      return true unless a.nil?
    end
    return false
  end

  def columns_win?(piece)
    rows_win?(piece, @board.transpose)
  end

  def diagonals_win?(piece)
    diags = find_diags
    antidiags = find_anti_diags
    rows_win?(piece, diags) || rows_win?(piece ,antidiags)
  end

  def find_diags
    diags = []
    (@@num_rows-1-3).downto(0) do |row|
      diag_arr = []
      i = row
      j=0
      while i < @@num_rows
        diag_arr.push(@board[i][j])
        i+=1
        j+=1
      end
      diags.push(diag_arr)
    end

    1.upto(@@num_columnns-1-3) do |column|
      diag_arr = []
      i = column
      j = 0
      while i<@@num_columnns
        diag_arr.push(@board[j][i])
        i+=1
        j+=1
      end
      diags.push(diag_arr)
    end
    return diags
  end

  def find_anti_diags
    diags = []
    (1).upto(@@num_columnns-1-3) do |column|
      diag_arr = []
      i = column
      j=@@num_rows-1
      while j >= 0
        diag_arr.push(@board[j][i]) if @board[j][i]
        i+=1
        j-=1
      end
      diags.push(diag_arr)
    end

    3.upto(@@num_rows-1) do |row|
      diag_arr = []
      i = row
      j = 0
      while i>=0
        diag_arr.push(@board[i][j])
        i-=1
        j+=1
      end
      diags.push(diag_arr)
    end
    return diags
  end

  def gameOver?(piece)
    rows_win?(piece) || columns_win?(piece) || diagonals_win?(piece)
  end

  def printBoard(board = @board)
    puts @columns.inspect.green
    puts
    board.each do |row|
      puts row.inspect
    end
  end

  def fullBoard?(board=@board)
    board.each do |row|
      return false if row.include?(' ')
    end
    return true
  end
  
  def play
    puts 'Enter name for Player 1: '
    p1 = Player.new(gets.chomp, 'X')
    puts 'Enter name for Player 2: '
    p2 = Player.new(gets.chomp, 'O')
    currentPlayer=p1
    while !fullBoard?
      puts "#{currentPlayer.name}'s turn: "
      printBoard
      addPiece(currentPlayer.token,getMove)
      printBoard
      return puts "#{currentPlayer.name} wins!" if gameOver?(currentPlayer.token)
      currentPlayer = swapTurn(currentPlayer, p1, p2)
    end
    return "A tie! Game over, no more empty spots"

  end
end
game =Connect4.new
game.play

# game.printBoard()
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# game.addPiece('X',game.getMove)
# game.printBoard
# puts

# puts game.rows_win?('X')
# puts
# puts game.columns_win?('X')
# puts
# puts game.diagonals_win?('X')