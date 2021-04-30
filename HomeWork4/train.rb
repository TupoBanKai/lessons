require_relative 'Instance_counter'
require_relative 'Module_owner'

class Train
  include InstanceCounter
  include Owner
  attr_reader :speed, :carriages, :type, :number, :train_composition, :route, :current_station

  def initialize(number)
    @type = ''
    @number = number
    validate_train_number!
    @carriages = []
    @speed = 0
    @@trains[number] = self
    @route
    @@instances = 0
    @current_station = nil
    register_instance
  end

  def take_overclocking
    return @speed = 60
  end

  def hit_the_brake
    return @speed = 0
  end

  def attach_carriage(carriage)
    if @speed == 0
      @carriages << carriage
    end
  end

  def unhook_carriage
    if @speed == 0
      @carriages.delete(@carriages.last)
    end
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
    if value == nil
      puts 'Its end station'
    else
      puts "Next station - #{value.name_station}"
    end
  end

  def move(value)
      @current_station.sending_trains(self)
      @route[@route.find_index(@current_station) + (value)].receiving_trains(self)
      @current_station = @route[@route.find_index(@current_station) + (value)]
  end

  def all_carriages(&block)
    @carriages.each do |carriage|
      if block_given?
        block(carriage).call
      end
    end
  end

  # protected
  TRAIN_NUMBER = /^(\w{3})|(\w{3}[-]\w{2})/
  @@trains = {}

  def self.find(number)
    if @@trains.include?(number)
      @@trains[number]
    else
      return nil
    end
  end

  def set_route(route)
    @route = route.stations
    @current_station = @route[0]
    @current_station.receiving_trains(self)
  end

  def validate_train_number!
    raise NameError if number !~ TRAIN_NUMBER
  end

  def valid?
    validate_train_number!
    true
    rescue
      false
  end
end