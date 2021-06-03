require_relative 'Card'

class Deck
  attr_reader :cards, :deck
  def initialize
    @deck = []
    @cards = {
      2 => ['clubs', 'diamonds', 'hearts', 'spades'], 3 => ['clubs', 'diamonds', 'hearts', 'spades'],
      4 => ['clubs', 'diamonds', 'hearts', 'spades'], 5 => ['clubs', 'diamonds', 'hearts', 'spades'],
      6 => ['clubs', 'diamonds', 'hearts', 'spades'], 7 => ['clubs', 'diamonds', 'hearts', 'spades'],
      8 => ['clubs', 'diamonds', 'hearts', 'spades'], 9 => ['clubs', 'diamonds', 'hearts', 'spades'],
      10 => ['clubs', 'diamonds', 'hearts', 'spades'], :v => ['clubs', 'diamonds', 'hearts', 'spades'],
      :q => ['clubs', 'diamonds', 'hearts', 'spades'], :k => ['clubs', 'diamonds', 'hearts', 'spades'],
      :a => ['clubs', 'diamonds', 'hearts', 'spades']
    }
  end

  def card_writer
    @cards.keys.each do |card|
      @cards[card].each { |suit| @deck.append(Card.new(card, suit)) }
    end
    rand_card
  end

  def rand_card
    @deck.shuffle!
  end
end
