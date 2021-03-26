class Calendar
  MONTHS = {
    1 => 31,
    2 => 28,
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31
    }

  def initialize(day, month, year)
    @day = day
    @month = month
    @year = year
    @i = 0
  end

  def find_number_day
    MONTHS.select do |key, value| 
      if key == @month
        @i += value
        break
      else
        @i += value
      end
    end
    leap_year(@i)
  end

  def leap_year(i)
    i -= @month - @day
    if @year % 4 == 0
      i += 1
    elsif @year % 100 == 0
      i -= 1
    elsif @year % 400 == 0
      i += 1 
    end
    print i
  end
end
calendar = Calendar.new(gets.to_i, gets.to_i, gets.to_i)
calendar.find_number_day