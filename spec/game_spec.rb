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

    it 'should return false if the slot don\'t match diagonaly' do
      allow(game).to receive(:matrix).and_return([%w[o _ x], %w[_ x o], %w[_ x _]])
      expect(game.check_diagonal).to eql(false)
    end
    
  end
end

