# frozen_string_literal: true

require_relative 'main'

# class player's action with program
class Simulation
  def initialize
    puts 'Hello player'
  end

  def begin(cards, value, bet)
    puts "Your cards: #{cards}"
    puts "Your value: #{value}"
    puts "Your bet: #{bet}"
  end

  def mid
    puts '1: Show cards'
    puts '2: Take a card'
  end

  def new_card(card, value)
    puts "Your card and new value: #{card}, #{value}"
  end

  def end_game(p_value, d_value, _who_win, cash)
    puts "Diler value - #{d_value}"
    puts "Your value - #{p_value}"
    if total
      puts 'Player win'
    elsif tital == 'Drow'
      puts 'Diler win'
    end
    puts "Your balance: #{cash}"
  end

  def one_more
    puts 'One more?'
    puts '1: Yes'
    puts '2: No'
  end
end
