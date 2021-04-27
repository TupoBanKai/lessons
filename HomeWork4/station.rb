require_relative 'InstanceCounter'
require_relative 'ModuleOwner'

class Station
  attr_reader :station_type_trains, :name_station
  include InstanceCounter
  include Owner

  def initialize(name_station)
    @name_station = name_station
    @station_type_trains = {:cargo => [], :passenger => []}
    @@all.append(self)
    register_instance
    valid?
  end

  def show_trains
    return @station_type_trains
  end 

  # private
  STATION_NAME = /^[a-zA-Z]{5,}/
  @@all = []

  def self.all
    @@all
  end

  def receiving_trains(train)
    items = @station_type_trains[train.type]
    items << train
    @station_type_trains[train.type] = items
  end

  def sending_trains(train)
    @station_type_trains[train.type].delete(train)
  end

  def validate_station_name!
    raise 'The name should not be 0 characters' if station_name != nil
    raise 'Use letters from a-z without numbers' if station_name !~ STATION_NAME
  end

  def valid?
    validate_station_name!
    true
    rescue
      false
  end
end