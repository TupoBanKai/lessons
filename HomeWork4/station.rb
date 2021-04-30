require_relative 'Instance_counter'
require_relative 'Module_owner'

class Station
  attr_reader :station_type_trains, :name_station
  include InstanceCounter
  include Owner

  def initialize(name_station)
    @name_station = name_station
    validate_station_name!
    @station_type_trains = {:cargo => [], :passenger => []}
    @trains = []
    @@all.append(self)
    register_instance
  end

  def show_trains
    return @station_type_trains
  end

  def all_trains(&block)
    @trains.each do |train|
      if block_given? 
        block.call(train)
      end
    end
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
    @trains.append(train)
  end

  def sending_trains(train)
    @station_type_trains[train.type].delete(train)
  end

  def validate_station_name!
    raise 'Use letters from a-z without numbers' if name_station !~ STATION_NAME
  end

  def valid?
    validate_station_name!
    true
    rescue
      false
  end
end