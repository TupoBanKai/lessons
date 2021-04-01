class Station
  attr_reader :station_type_trains, :name_station

  def initialize(name_station)
    @name_station = name_station
    @station_type_trains = {'Cargo' => [], 'Pasenger' => []}
  end

  def receiving_trains(train)
    items = @station_type_trains[train.type]
    items << train
    @station_type_trains[train.type] = items
  end

  def sending_trains(train)
    @station_type_trains[train.type].delete(train)
  end

  def show_trains
    puts @station_type_trains['Cargo'].map { |train| "#{train.type} #{train.number}" }
    puts @station_type_trains['Pasenger']
    puts "Cargo's count = #{@station_type_trains['Cargo'].count}"
    puts "Pasenger's count = #{@station_type_trains['Pasenger'].count}"
  end

end

class Route
  attr_reader :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @way = []
  end

  def add_intermediate_station(station)
    @way << station
  end

  def delete_station(name)
    if @way.include?(name)
      @way.delete(name)
    else
      puts "#{name} - There is no such station"
    end
  end

  def stations
    [@start_station, *@way, @end_station]
  end
end

class Train
  attr_reader :speed, :carriages, :type, :number

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
    @current_station.receiving_trains(self)
  end

  def move_next
    if @current_station != @route.last
      @current_station.sending_trains(self)
      @route[@route.find_index(@current_station) + 1].receiving_trains(self)
    else
      puts 'You have already arrived at your destination'
    end
  end

  def move_previos
    if @current_station != @route.first
      @current_station.sending_trains(self)
      @route.stations[@route.find_index(@current_station) - 1].receiving_trains(self)
    else
      puts 'You are already at the starting point of the route'
    end
  end

  def current_station
    puts "Current station - #{@current_station.name_station}"
  end

  def previos_station
    value = @route[@route.find_index(@current_station) - 1]
    if value == @route.last
      puts 'Its start station'
    else
      puts "Previos station - #{value.name_station}"
    end
  end

  def next_station
    value = @route[@route.find_index(@current_station) + 1]
    if value == nil
      puts 'Its end station'
    else
      puts "Next station - #{value.name_station}"
    end
  end
end

station = Station.new('Volga')
station2 = Station.new('NeVolga')
route = Route.new(station, station2)
train = Train.new(10, 'Cargo', 20)
train.set_route(route)
train.move_next
train.current_station
train.previos_station
train.next_station
station.show_trains