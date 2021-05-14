# frozen_string_literal: true

# class for choice
class Log
  def ftr_log
    puts 'Choose where to send the train:'
    puts '1: Move train'
    puts '2: Show trains on station'
    puts '0: End route'
  end

  def awc_log
    puts '1: Attach carriages'
    puts '2: Fill capacity'
  end

  def ta_log
    puts '1: Follow the route'
    puts '2: Actions with carriages'
    puts '0: Exit'
  end

  def awt_log
    puts '1: Create a train'
    puts '2: Select existing'
  end

  def start_log
    puts '1: Route actions'
    puts '2: Actions with trains'
    puts '0: Exit programm'
  end

  def cc_log
    puts '1: Disconnect carriages'
    puts '2: Show carriages'
  end
end
