# frozen_string_literal : true

require 'rspec'

require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'creates a 3x3 grid with numbered tiles' do
      expect(board.instance_variable_get(:@grid).flatten).to eq(('1'..'9').to_a)
    end
  end

  describe '#update' do
    it 'allows valid moves' do
      expect(board.update(5, 'X')).to be true
      expect(board.instance_variable_get(:@grid)[1][1]).to eq('X')
    end

    it 'rejects occupied positions' do
      board.update(5, 'X')
      expect(board.update(5, 'O')).to be false
    end
  end

  describe '#full?' do
    it 'returns false for new board' do
      expect(board.full?).to be false
    end

    it 'returns true when all tiles are filled' do
      (1..9).each { |pos| board.update(pos, 'X') }
      expect(board.full?).to be true
    end
  end

  describe '#reset' do
    it 'reinitializes the board' do
      board.update(1, 'X')
      board.reset
      expect(board.instance_variable_get(:@grid)).to eq([%w[1 2 3], %w[4 5 6], %w[7 8 9]])
    end
  end
end
