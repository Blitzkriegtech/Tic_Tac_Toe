# frozen_string_literal: true

require 'rspec'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

RSpec.describe Game do
  subject(:game) { described_class.new }

  before do
    allow($stdout).to receive(:write) # silences console output during tests
  end

  describe '#switch_player' do
    it 'alternates between players' do
      initial_player = game.instance_variable_get(:@current_player)
      game.send(:switch_player)
      new_player = game.instance_variable_get(:@current_player)
      expect(new_player).not_to eq(initial_player)
    end
  end

  describe '#winner?' do
    it 'detects horizontal wins' do
      board = game.instance_variable_get(:@board)
      [1, 2, 3].each { |pos| board.update(pos, 'X') }
      expect(game.send(:winner?)).to be true
    end

    it 'detects vertical wins' do
      board = game.instance_variable_get(:@board)
      [3, 6, 9].each { |pos| board.update(pos, 'O') }
      game.instance_variable_set(:@current_player, game.instance_variable_get(:@player2))
      expect(game.send(:winner?)).to be true
    end

    it 'detects diagonal wins' do
      board = game.instance_variable_get(:@board)
      [1, 5, 9].each { |pos| board.update(pos, 'X') }
      expect(game.send(:winner?)).to eq true
    end
  end

  describe '#draw?' do
    it 'delegates to board#full?' do
      board = game.instance_variable_get(:@board)
      allow(board).to receive(:full?).and_return(true)
      expect(game.send(:draw?)).to be true
    end
  end

  describe '#replay?' do
    it 'returns true for Y' do
      allow(game).to receive(:gets).and_return("Y\n")
      expect(game.send(:replay?)).to be true
    end

    it 'returns false for N' do
      allow(game).to receive(:gets).and_return("N\n")
      expect(game.send(:replay?)).to be false
    end

    it 'reprompts on invalid input' do
      allow(game).to receive(:gets).and_return("invalid\n", "Y\n")
      expect(game.send(:replay?)).to be true
    end
  end
end
