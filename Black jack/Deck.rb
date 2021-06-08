# frozen_string_literal: true

require_relative 'card'

# for generate random deck
class Deck
  attr_reader :cards, :deck

  def initialize
    @deck = []
  end

  def card_writer
    Card::NAME.each do |card|
      Card::SUIT.each { |suit| @deck.append(Card.new(card, suit)) }
    end
    rand_card
  end

  def rand_card
    @deck.shuffle!
  end
end
