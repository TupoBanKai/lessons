class Station
  attr_reader :current_trains, :station_type_trains

  def initialize(name_station)
    @name_station = name_station
    @current_trains = []
    @station_type_trains = {}
  end

  def receiving_trains(train_type)
      @current_trains << train_type
      @station_type_trains[train_type] = @station_type_trains[train_type].to_i + 1
  end

  def sending_trains
    @current_trains.delete(0)
  end
end

class Route
  attr_reader :start_station, :end_station
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @way = []
  end

  def add_intermediate_station(statin)
    @way << statin
  end

  def delete_station(name)
    if @way.include?(name)
      @way.delete(name)
    else
      puts "#{name} - There is no such station"
    end
  end

  def stations
    return [@start_station, *@way, @end_station]
  end
end

class Train
  attr_reader :speed, :carriages

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
    @route = nil
    @current_station = nil
  end

  def take_overclocking
    return @speed = 60
  end

  def hit_the_brake
    return @speed = 0
  end

  def attach_carriage
    if @speed == 0
      return @carriages += 1
    else
      puts 'You need hit_the_brake'
    end
  end

  def unhook_carriage
    if @speed == 0
      return @carriages -= 1
    else
      puts 'You need hit_the_brake'
    end
  end

  def set_route(route)
    @route = route.stations
    @current_station = @route.first
    @current_station.receiving_trains(@type)
  end

  def move_next
    if @current_station != @route.last
      @current_station.sending_trains
      @route[@route.find_index(@current_station) + 1].receiving_trains(@type)
    else
      puts 'You have already arrived at your destination'
    end
  end

  def move_previos
    if @current_station != @route.first
      @current_station.sending_trains
      @route.stations[@route.find_index(@current_station) - 1].receiving_trains(@type)
    else
      puts 'You are already at the starting point of the route'
    end
  end
end

station = Station.new('Volga')
station2 = Station.new('NeVolga')
route = Route.new(station, station2)
train = Train.new(10, 'Cargo', 20)
train.set_route(route)
train.move_next