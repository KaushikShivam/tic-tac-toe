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
end
