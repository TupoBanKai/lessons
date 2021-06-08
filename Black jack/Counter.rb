# frozen_string_literal: true

# for counter
class Counter
  attr_accessor :value

  POINT = 21

  def initialize
    @value = 0
  end

  def counter(*cards)
    names = %i[v q k a]
    cards.each do |card|
      if !names.include?(card.name)
        integer_counter(card.name)
      elsif card.name == :a
        ace_counter
      else
        picture_counter
      end
    end
  end

  def ace_counter
    if (@value + 11) < POINT
      @value += 11
    else
      @value += 1
    end
  end

  def picture_counter
    @value += 10
  end

  def integer_counter(name)
    @value += name.to_i
  end

  def who_win(player_value, diler_value)
    if (player_value == POINT) && (diler_value == POINT)
      true
    elsif (player_value > POINT) && (player_value < diler_value)
      true
    elsif player_value == POINT
      true
    elsif (player_value <= POINT) && (player_value > diler_value)
      true
    elsif (player_value < POINT) && (diler_value > POINT)
      true
    elsif (player_value >= POINT) && (diler_value > POINT)
      true
    else
      player_value == diler_value
    end
  end
end
