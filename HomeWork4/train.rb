require_relative 'InstanceCounter'
require_relative 'ModuleOwner'

class Train
  include InstanceCounter
  include Owner
  attr_reader :speed, :carriages, :type, :number, :train_composition, :route, :current_station

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @@trains[number] = self
    @route
    @@instances = 0
    register_instance
  end

  def take_overclocking
    return @speed = 60
  end

  def hit_the_brake
    return @speed = 0
  end

  def attach_carriage(carriage)
    if @type == carriage.type || @speed == 0
      @carriages << type
    end
  end

  def unhook_carriage(carriage)
    if @type == carriage.type || @speed == 0
      @carriages.delete(@carriages.last)
    end
  end

  def current_station
    if @current_station == nil
      puts 'Current station eshe net'
    else
      return @current_station.name_station
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

  # protected

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
end