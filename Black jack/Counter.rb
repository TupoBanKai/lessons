class Counter
  attr_accessor :value
  POINT = 21

  def initialize
    @value = 0
  end

  def counter(*cards)
    names = [:v, :q, :k, :a]
    cards.each do |card|
      if !(names.include?(card.name))
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
    else (@value + 11) > POINT
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
    if player_value == POINT and diler_value == POINT
      true
    elsif player_value > POINT and player_value < diler_value
      true
    elsif player_value == POINT
      true
    elsif player_value <= POINT and player_value > diler_value
      true
    elsif player_value < POINT and diler_value > POINT
      true
    elsif player_value >= POINT and diler_value > POINT
      true
    elsif player_value == diler_value
      true
    else
      false
    end
  end
end
