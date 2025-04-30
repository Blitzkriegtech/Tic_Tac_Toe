# frozen_string_literal: true

require 'rspec'
require_relative '../lib/player'

RSpec.describe Player do
  subject(:player) { described_class.new('Test Player', 'X') }

  describe '#initialize' do
    it 'sets name and marker' do
      expect(player.name).to eq('Test Player')
      expect(player.marker).to eq('X')
    end
  end
end
