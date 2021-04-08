class Train
  attr_reader :speed, :carriages, :type, :number, :train_composition

  def initialize(number)
    @number = number
    @type = nil
    @train_composition = []
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

  def attach_carriage(carriage)
    if @type == carriage || @speed == 0
      @train_composition << type
      @train_composition.each { |carriage| puts "#{type.carriage}" }
    else
      puts 'You need hit_the_brake or chek carriage type'
    end
  end

  def unhook_carriage(carriage)
    if @type == carriage || @speed == 0
      @train_composition.delete(@train_composition.last)
      @train_composition.each { |carriage| puts "#{carriage.carriage}" }
    else
      puts 'You need hit_the_brake'
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

  def move_next
    if @current_station != @route.last
      @current_station.sending_trains(self)
      @route[@route.find_index(@current_station) + 1].receiving_trains(self)
      @current_station = @route[@route.find_index(@current_station) + 1]
    else
      puts 'You have already arrived at your destination'
    end
  end

  def move_previos
    if @current_station != @route.first
      @current_station.sending_trains(self)
      @route.stations[@route.find_index(@current_station) - 1].receiving_trains(self)
      @current_station = @route.stations[@route.find_index(@current_station) - 1]
    else
      puts 'You are already at the starting point of the route'
    end
  end

  # protected

  def set_route(route)
    @route = route.stations
    @current_station = route.start_station
    @current_station.receiving_trains(self)
  end
end