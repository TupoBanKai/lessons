# frozen_string_literal: true

require_relative 'Instance_counter' # counter class var
require_relative 'Module_owner' # to set owner
require_relative 'module_accessor'
require_relative 'module_validation'

# responsible for creating the train
class Train
  include InstanceCounter
  include Owner
  include Accessor
  include Validation

  attr_accessor_with_history :speed, :carriages, :type, :number, :train_composition, :route, :current_station

  validate :number, :format, /^(\w{3})|(\w{3}-\w{2})/.freeze

  def initialize(number)
    @number = number
    @type = ''
    @carriages = []
    @speed = 0
    @current_station = nil
    register_instance
    Train.foo(number)
  end

  def take_overclocking
    @speed = 60
  end

  def hit_the_brake
    @speed = 0
  end

  def attach_carriage(carriage)
    hit_the_brake
    @carriages << carriage if @speed.zero?
  end

  def unhook_carriage
    hit_the_brake
    @carriages.delete(@carriages.last) if @speed.zero?
  end

  def show_previos_station
    value = @route[@route.find_index(@current_station) - 1]
    if value == @route.last
      puts 'Its start station'
    else
      puts "Previos station - #{value.name_station}"
    end
  end

  def show_next_station
    value = @route[@route.find_index(@current_station) + 1]
    if value.nil?
      puts 'Its end station'
    else
      puts "Next station - #{value.name_station}"
    end
  end

  def move(value)
    @current_station.sending_trains(self)
    @route[@route.find_index(@current_station) + value].receiving_trains(self)
    @current_station = @route[@route.find_index(@current_station) + value]
  end

  def all_carriages
    @carriages.each do |carriage|
      block(carriage).call if block_given?
    end
  end

  # protected
  @trains = {}

  def self.foo(number)
    @trains[number] = self
  end

  def self.find(number)
    @trains[number] if @trains.include?(number)
  end

  def appoint_route(route)
    @route = route.stations
    @current_station = @route[0]
    @current_station.receiving_trains(self)
  end
end
