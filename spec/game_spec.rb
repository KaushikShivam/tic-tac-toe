require './lib/game.rb'

RSpec.describe Game do
  let(:game){ Game.new }

  describe '#check_move' do
    it 'should return true if either of the methods return true' do
      allow(game).to receive(:check_diagonal).and_return(false)
      allow(game).to receive(:check_vertical).and_return(false)
      allow(game).to receive(:check_horizontal).and_return(true)
      expect(game.check_move).to eql(true)
    end

    it 'should return false if niether of the methods return true' do
      allow(game).to receive(:check_diagonal).and_return(false)
      allow(game).to receive(:check_vertical).and_return(false)
      allow(game).to receive(:check_horizontal).and_return(false)
      expect(game.check_move).to eql(false)
    end
  end
  describe '#check_diagonal' do
    it 'should return true if the slots match diagonaly from left' do
      allow(game).to receive(:matrix).and_return([%w[x _ o], %w[_ x o], %w[_ _ x]])
      expect(game.check_diagonal).to eql(true)
    end

    it 'should return true if the slots match diagonaly from right' do
      allow(game).to receive(:matrix).and_return([%w[o _ x], %w[_ x o], %w[x _ _]])
      expect(game.check_diagonal).to eql(true)
    end

    it 'should return false if the slots don\'t match diagonaly' do
      allow(game).to receive(:matrix).and_return([%w[o _ x], %w[_ x o], %w[_ x _]])
      expect(game.check_diagonal).to eql(false)
    end
  end

  describe '#check_vertical' do
    it 'should return true if the slots match vertically from first column' do
      allow(game).to receive(:matrix).and_return([%w[x _ o], %w[x _ o], %w[x _ _]])
      expect(game.check_vertical).to eql(true)
    end
    it 'should return true if the slots match vertically from second column' do
      allow(game).to receive(:matrix).and_return([%w[_ x o], %w[o x o], %w[_ x _]])
      expect(game.check_vertical).to eql(true)
    end
    it 'should return true if the slots match vertically from third column' do
      allow(game).to receive(:matrix).and_return([%w[x _ o], %w[_ _ o], %w[x _ o]])
      expect(game.check_vertical).to eql(true)
    end
    it 'should return false if the slots don\'t match vertically from any columns' do
      allow(game).to receive(:matrix).and_return([%w[x _ _], %w[x _ o], %w[_ _ o]])
      expect(game.check_vertical).to eql(false)
    end
  end

  describe '#check_horizontal' do
    it 'should return true if the slots match horizontally from first row' do
      allow(game).to receive(:matrix).and_return([%w[x x x], %w[o _ o], %w[o _ _]])
      expect(game.check_horizontal).to eql(true)
    end
    it 'should return true if the slots match horizontally from second row' do
      allow(game).to receive(:matrix).and_return([%w[_ o o], %w[x x x], %w[_ o _]])
      expect(game.check_horizontal).to eql(true)
    end
    it 'should return true if the slots match horizontally from third row' do
      allow(game).to receive(:matrix).and_return([%w[o _ o], %w[_ _ o], %w[x x x]])
      expect(game.check_horizontal).to eql(true)
    end
    it 'should return false if the slots don\'t match horizontally from any row' do
      allow(game).to receive(:matrix).and_return([%w[x _ _], %w[x _ o], %w[_ _ o]])
      expect(game.check_horizontal).to eql(false)
    end
  end

  describe '#finished?' do
    it 'should not return false if the winner is not nil or if drawn is true' do
      allow(game).to receive_messages(winner: 1, drawn?: true)
      expect(game.finished?).to_not eql(false)
    end
    it 'should not return false if the winner is 1 & drawn is false' do
      allow(game).to receive_messages(winner: 1, drawn?: false)
      expect(game.finished?).to_not eql(false)
    end
    it 'should return false if the winner is nil & if drawn is false' do
      allow(game).to receive_messages(winner: nil, drawn?: false)
      expect(game.finished?).to eql(false)
    end
    it 'should return true if the winner is nil & drawn is true' do
      allow(game).to receive_messages(winner: nil, drawn?: true)
      expect(game.finished?).to eql(true)
    end
  end

  describe '#drawn?' do
    it 'should return true if the move counter is equal to 9' do
      allow(game).to receive(:counter).and_return(9)
      expect(game.drawn?).to eql(true)
    end
    it 'should return false if the move counter is smaller than 9' do
      9.times do |x|
        allow(game).to receive(:counter).and_return(x)
        expect(game.drawn?).to eql(false)
      end
    end
  end

  describe '#slot_taken?' do
    it 'should return false if no slot is taken' do
      allow(game).to receive(:matrix).and_return([%w[_ _ _], %w[_ _ _], %w[_ _ _]])
      (1..3).each do |row|
        (1..3).each do |col|
          expect(game.slot_taken?(row, col)).to eql(false)
        end
      end
    end

    it 'should return true if a slot is taken' do
      allow(game).to receive(:matrix).and_return([%w[_ x _], %w[_ _ _], %w[_ _ _]])
      (1..3).each do |row|
        (1..3).each do |col|
          if row == 1 && col == 2 
            expect(game.slot_taken?(row, col)).to eql(true)
          else
            expect(game.slot_taken?(row, col)).to eql(false)
          end
        end
      end
    end      
  end

  describe '#handle_move' do
   it 'should update the winner if check_move return true' do
    allow(game).to receive_messages(check_move:true,active_player:0)
    expect(game.winner).to eql(nil)
    game.handle_move
    expect(game.winner).to eql(0)
   end
   
   it 'should change the active player if check_move return false' do
    allow(game).to receive_messages(check_move:false)
    game.active_player=0
    expect(game.active_player).to eql(0)
    game.handle_move
    expect(game.active_player).to eql(1)
   end
  end
end
