# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'counter'
require_relative 'player'
require_relative 'diler'
require_relative 'bank'
require_relative 'simulation'

# class main for create anth
class Main
  @@bank = Bank.new

  def initialize
    @deck = Deck.new
    @deck.card_writer
    @user_cards = [@deck.deck.pop, @deck.deck.pop]
    @diler_cards = [@deck.deck.pop, @deck.deck.pop]
    @player = Player.new(@user_cards, @deck.deck.pop)
    @diler = Diler.new(@diler_cards, @deck.deck.pop)
    @counter = Counter.new
    @sim = Simulation.new
  end

  def start
    cards = @user_cards.each { |card| puts "#{card.name} - #{card.suit}" }
    value = @player.count_value
    bet = @@bank.bet
    @sim.begin(cards, value, bet)
    diler_turn
  end

  def continuation
    @sim.mid
    answer = gets.to_i
    case answer
    when 1
      end_game
    when 2
      @player.add_card
      third_card = "#{@player.third_card.name} - #{@player.third_card.suit}"
      new_value = @player.count_value
      @sim.new_card(third_card, new_value)
      end_game
    end
  end

  def end_game
    d_value = @diler.count_value
    p_value = @player.count_value
    total = @counter.who_win(p_value, d_value)
    cash = @@bank.cash_account
    if total
      @@bank.place_bet
      @sim.final(d_value, p_value, total, cash)
    elsif total != 'Drow'
      @@bank.seizure
      @sim.final(d_value, p_value, total, cash)
    end
    continue
  end

  def continue
    @sim.one_more
    answer = gets.to_i
    case answer
    when 1
      initialize
      start
    when 2
      true
    end
  end

  def diler_turn
    @diler.add_card if @diler.count_value < 17
  end
end

main = Main.new
main.start
