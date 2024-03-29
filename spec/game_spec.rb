# frozen_string_literal: true

require './lib/game.rb'

RSpec.describe Game do
  let(:game) { Game.new }

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
      allow(game).to receive(:matrix)
        .and_return([%w[x _ o], %w[_ x o], %w[_ _ x]])
      expect(game.check_diagonal).to eql(true)
    end

    it 'should return true if slots match diagonaly from right' do
      allow(game).to receive(:matrix)
        .and_return([%w[o _ x], %w[_ x o], %w[x _ _]])
      expect(game.check_diagonal).to eql(true)
    end

    it 'should return false if the slots don\'t match diagonaly' do
      allow(game).to receive(:matrix)
        .and_return([%w[o _ x], %w[_ x o], %w[_ x _]])
      expect(game.check_diagonal).to eql(false)
    end
  end

  describe '#check_vertical' do
    it 'should return true if the slots match vertically from first column' do
      allow(game).to receive(:matrix)
        .and_return([%w[x _ o], %w[x _ o], %w[x _ _]])
      expect(game.check_vertical).to eql(true)
    end

    it 'should return true if the slots match vertically from second column' do
      allow(game).to receive(:matrix)
        .and_return([%w[_ x o], %w[o x o], %w[_ x _]])
      expect(game.check_vertical).to eql(true)
    end

    it 'should return true if the slots match vertically from third column' do
      allow(game).to receive(:matrix)
        .and_return([%w[x _ o], %w[_ _ o], %w[x _ o]])
      expect(game.check_vertical).to eql(true)
    end

    it 'should return false if slots don\'t match vertically' do
      allow(game).to receive(:matrix)
        .and_return([%w[x _ _], %w[x _ o], %w[_ _ o]])
      expect(game.check_vertical).to eql(false)
    end
  end

  describe '#check_horizontal' do
    it 'should return true if the slots match horizontally from first row' do
      allow(game).to receive(:matrix)
        .and_return([%w[x x x], %w[o _ o], %w[o _ _]])
      expect(game.check_horizontal).to eql(true)
    end

    it 'should return true if the slots match horizontally from second row' do
      allow(game).to receive(:matrix)
        .and_return([%w[_ o o], %w[x x x], %w[_ o _]])
      expect(game.check_horizontal).to eql(true)
    end

    it 'should return true if the slots match horizontally from third row' do
      allow(game).to receive(:matrix)
        .and_return([%w[o _ o], %w[_ _ o], %w[x x x]])
      expect(game.check_horizontal).to eql(true)
    end

    it 'should return false if slots don\'t match horizontally from any row' do
      allow(game).to receive(:matrix)
        .and_return([%w[x _ _], %w[x _ o], %w[_ _ o]])
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
      allow(game).to receive(:matrix)
        .and_return([%w[_ _ _], %w[_ _ _], %w[_ _ _]])
      (1..3).each do |row|
        (1..3).each do |col|
          expect(game.slot_taken?(row, col)).to eql(false)
        end
      end
    end

    it 'should return true if a slot is taken' do
      allow(game).to receive(:matrix)
        .and_return([%w[_ x _], %w[_ _ _], %w[_ _ _]])
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
      allow(game).to receive_messages(check_move: true, active_player: 0)
      expect(game.winner).to eql(nil)
      game.handle_move
      expect(game.winner).to eql(0)
    end

    it 'should change the active player if check_move return false' do
      allow(game).to receive_messages(check_move: false)
      game.active_player = 0
      expect(game.active_player).to eql(0)
      game.handle_move
      expect(game.active_player).to eql(1)
    end
  end

  describe '#update_matrix' do
    let(:player) { double('Player') }

    it 'should return false if slot_taken? returns true' do
      allow(game).to receive_messages(slot_taken?: true)
      expect(game.update_matrix(2, 2)).to eql(false)
    end

    it 'should return true if slot_taken? returns false' do
      allow(player).to receive('symbol').and_return('x')
      allow(game)
        .to receive_messages(slot_taken?: false, find_active_player: player)
      expect(game.update_matrix(2, 2)).to eql(true)
    end

    it 'should increment count if slot_taken? returns false' do
      allow(player).to receive('symbol').and_return('x')
      allow(game)
        .to receive_messages(slot_taken?: false, find_active_player: player)
      game.counter = 0
      game.update_matrix(2, 2)
      expect(game.counter).to eql(1)
    end

    it 'should update matrix if slot_taken? returns false' do
      allow(player).to receive('symbol').and_return('x')
      allow(game)
        .to receive_messages(slot_taken?: false, find_active_player: player)
      game.matrix = [%w[_ o _], %w[_ _ _], %w[_ _ _]]
      game.update_matrix(2, 2)
      expect(game.matrix).to eq([%w[_ o _], %w[_ x _], %w[_ _ _]])
    end
  end

  describe '#find_active_player' do
    it 'should return the active player object' do
      players = [double('player1'), double('player2')]
      game.players = players
      game.active_player = 0
      expect(game.find_active_player).to eql(players[0])
    end
  end

  describe '#switch_active_player' do
    it 'should switch the active player object' do
      game.active_player = 0
      game.switch_active_player
      expect(game.active_player).to eql(1)
    end
  end

  describe '#display_matrix' do
    it 'should return the matrix as a string' do
      game.matrix = [%w[x x x], %w[o _ o], %w[o _ _]]
      expect(game.display_matrix).to eql("x x x\no _ o\no _ _\n")
    end
  end

  describe '#initialize' do
    it 'should return a matrix variable' do
      expect(game.matrix).to eql([%w[_ _ _], %w[_ _ _], %w[_ _ _]])
    end

    it 'should return an empty players array' do
      expect(game.players).to eql([])
    end

    it 'should set 0 for the active player' do
      expect(game.active_player).to eql(0)
    end

    it 'should set 0 for the counter' do
      expect(game.counter).to eql(0)
    end

    it 'should set winner to nil' do
      expect(game.winner).to eql(nil)
    end
  end
end
