require './connect4'
RSpec.describe Connect4 do
  let(:game) {Connect4.new}

  describe '#makeBoard' do
    it 'returns an array with 7 columns and 6 rows' do
      board_expected = [[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],
      [" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "]]
      expect(game.makeBoard).to eql(board_expected)
    end
  end

  describe '#addPiece' do
    it 'adds Player game piece to given column on board' do
      board_expected = game.makeBoard
      board_expected[5][0] = 'X'
      game.addPiece('X','0')
      expect(game.board).to eql (board_expected)
    end
  end

  describe "#getMove" do
    it 'makes sure user enters correct format for a move and returns the move' do
      move = game.getMove
      goodMove = move.to_i.to_s == move && move.to_i.between?(0,Connect4.num_columns)
      expect(goodMove).to eql true
    end
  end

  describe '#gameOver?' do
    it 'given a piece, returns true if that piece has a winning combination on the board' do
      game.addPiece('X',0)
      game.addPiece('X',1)
      game.addPiece('X',2)
      game.addPiece('X',3)
      expect(game.gameOver?('X')).to eql true
    end
  end

  describe '#swapTurn' do
    it 'given the current player, switches the turn over to the other player' do
      p1 = 'player1'
      p2 = 'player2'
      current = p1
      expect(game.swapTurn(current, p1, p2)).to eql p2
    end
  end

  describe '#fullBoard?' do
    it 'returns true when the game board has no remaining empty spots' do
      fullBoard = game.makeBoard
      fullBoard.each do |row|
        row.each_with_index do |spot, index|
          row[index] = 'X'
        end
      end
      expect(game.fullBoard?(fullBoard)).to eql true
    end

    it 'returns false when the game board has at least one empty spot' do
      fullBoard = game.makeBoard
      fullBoard.each do |row|
        row.each_with_index do |spot, index|
          row[index] = 'X'
        end
      end
      fullBoard[0][0] = ' '
      expect(game.fullBoard?(fullBoard)).to eql false
    end
  end


end