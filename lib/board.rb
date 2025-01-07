# frozen_string_literal: true

# Handles board display, player move updates, and board status.
class Board
  def initialize
    @grid = Array.new(3) { |row| Array.new(3) { |col| (row * 3 + col + 1).to_s } }
  end

  def display
    @grid.each do |row|
      puts row.join(' | ')
      puts '*********' unless row == @grid.last
    end
  end

  # #update gets the value for rows and columns indices.

  def update(position, marker)
    row = (position - 1) / 3
    col = (position - 1) % 3
    if @grid[row][col].match?(/\d/)
      @grid[row][col] = marker
      true
    else
      false
    end
  end

  def full?
    @grid.flatten.none? { |tile| tile.match?(/\d/) }
  end

  def reset
    puts 'Game on!'
    @grid = Array.new(3) { |row| Array.new(3) { |col| (row * 3 + col + 1).to_s } }
  end
end
