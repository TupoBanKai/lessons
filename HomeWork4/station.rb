# frozen_string_literal: true

require_relative 'Instance_counter' # counter class var
require_relative 'Module_owner' # to set owner
require_relative 'module_accessor'
require_relative 'module_validation'

# responsible for creating stations for trains
class Station
  include InstanceCounter
  include Owner
  include Accessor
  include Validation

  attr_accessor_with_history :station_type_trains, :name_station

  validate :name_station, :format, /^[a-zA-Z]{5,}/.freeze

  @all = []

  def initialize(name_station)
    @name_station = name_station
    validate!
    @station_type_trains = { cargo: [], passenger: [] }
    @trains = []
    register_instance
    Station.all
  end

  def self.all
    @all.append(self)
  end

  def show_trains
    @station_type_trains
  end

  def all_trains(&block)
    @trains.each do |train|
      block.call(train) if block_given?
    end
  end

  # private

  def receiving_trains(train)
    items = @station_type_trains[train.type]
    items << train
    @station_type_trains[train.type] = items
    @trains.append(train)
  end

  def sending_trains(train)
    @station_type_trains[train.type].delete(train)
  end
end
