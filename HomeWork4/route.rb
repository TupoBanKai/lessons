class Route
  attr_reader :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate = []
    @way = []
  end

  def change_start_station(name) #private?
    @start_station = Station.new(name)
  end

  def change_end_station(name) #private?
    @end_station = Station.new(name)
  end

  def add_intermediate_station(name)
    @intermediate << Station.new(name)
  end

  def delete_start_station
    @start_station = nil
  end

  def delete_end_station
    @end_station = nil
  end

  def delete_intermediate_station(name)
    @intermediate.delete(@intermediate[@intermediate.find_index(name).to_i])
  end

  def stations
    [@start_station, *@intermediate, @end_station]
  end
end