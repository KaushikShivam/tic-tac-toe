# frozen_string_literal: true

require './lib/player.rb'

RSpec.describe Player do
  it 'should create a Player object with a symbol x' do
    player = Player.new('x')
    expect(player.symbol).to eql('x')
  end
  it 'should create a Player object with a symbol o' do
    player = Player.new('o')
    expect(player.symbol).to eql('o')
  end
  it 'should raise ArgumentError if no argument is given' do
    expect { Player.new }.to raise_error(ArgumentError)
  end
end
