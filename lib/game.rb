# frozen_string_literal: true

# Handles the entire game flow of the game.
class Game
  require_relative 'board'
  require_relative 'player'

  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @current_player = @player1
    puts "Game on! Please begin #{@current_player.name}."
  end

  def play
    loop do
      @board.display
      move = player_move
      next unless process_move(move) == true

      @board.display
      announce_result
      unless replay?

        puts 'Thank you for playing. Hope you enjoy the game.'
        break
      end
      @board.reset
    end
  end

  private

  def player_move
    loop do
      print "#{@current_player.name} please input a pos/tile no. between 1 to 9: "
      input = gets.chomp
      return input.to_i unless input.match?(/^[1-9]$/) == false

      puts 'Invalid input. Please select a no. between 1 to 9.'
    end
  end

  def process_move(move)
    if @board.update(move, @current_player.marker)
      return true if winner? || draw?

      switch_player
    end
    false
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def announce_result
    if winner?
      puts "#{@current_player.name} won!! Gratz :)"
    elsif draw?
      puts "It's a DRAW!! XD"
    end
  end

  def draw?
    @board.full?
  end

  def winner?
    win_patterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]

    flattened_grid = @board.instance_variable_get(:@grid).flatten
    win_patterns.any? do |pattern|
      pattern.all? { |index| flattened_grid[index] == @current_player.marker }
    end
  end

  # Handles the replay of the game after the result is announced.

  def replay?
    loop do
      print 'Would you like to play another round? Y/N: '
      answer = gets.chomp.downcase
      result = { 'y' => true, 'n' => false }[answer]
      return result unless result.nil? == true

      puts 'Invalid input. Please input either Y or N.'
    end
  end
end
