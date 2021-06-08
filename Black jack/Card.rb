# frozen_string_literal: true

require_relative 'deck'

# class for a card from the deck
class Card
  attr_reader :name, :suit

  NAME = [2, 3, 4, 5, 6, 7, 8, 9, 10, :v, :q, :k, :a].freeze
  SUIT = %w[clubs diamonds hearts spades].freeze

  def initialize(name, suit)
    @name = name
    @suit = suit
  end
end
