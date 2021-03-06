# frozen_string_literal: true

require_relative 'counter'
require_relative 'deck'

# class for create Player and Diler
class User
  attr_reader :value, :third_card

  def initialize(cards, third_card)
    @third_card = third_card
    @cards = cards
    @counter = Counter.new
    @value = 0
  end

  def add_card
    @cards.append(@third_card)
  end

  def count_value
    @counter.value = 0
    @value = 0
    @cards.each { |card| @counter.counter(card) }
    @value = @counter.value
  end
end
