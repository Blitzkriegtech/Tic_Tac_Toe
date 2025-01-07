# frozen_string_literal: true

# Handles player data.
class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end
