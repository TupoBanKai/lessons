module Validate
  STATION_NAME = /^[a-zA-Z]{,20}/
  TRAIN_NUMBER = /^\d{6}/

  def validate_station_name!
    raise 'Station name cant be nil' @station_name.nil?
    raise 'Use letters from a-z without numbers' if !~ STATION_NAME
    raise 'The name should not be 20 characters' if @station_name.lenght > 20
  end

  def validate_train_number!
    raise 'Number cant be nil' @number.nil?
    raise 'Number should be at least 6 symbols' if @number.lenght < 6
    raise 'Number ne tot' if !~ TRAIN_NUMBER
  end

  def valid?(method)
    method
    true
  rescue
    false
  end

end