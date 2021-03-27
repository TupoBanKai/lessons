class Calendar
  def initialize(day, month, year)
    @day = day
    @month = month
    @year = year
    @sum_day = 0
  end

  def months(l_year)
    febrary_days = if l_year
      29
  	else
  	  28
    end
    {
      1 => 31,
      2 => febrary_days,
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
  end

  def find_number_day
    months(leap_year).select do |key, value| 
      if key == @month
        @sum_day += value
        break
      else
        @sum_day += value
      end
    end
    counter
  end

  def leap_year
    @year % 400 == 0 || ( @year % 4 == 0 && @year % 100 != 0)
  end

  def counter
  	print @sum_day
  end
end
calendar = Calendar.new(gets.to_i, gets.to_i, gets.to_i)
calendar.find_number_day