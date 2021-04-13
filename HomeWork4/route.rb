class Route
  attr_reader :start_station, :end_station

  def initialize(start_station, end_station, intermediate)
    @start_station = start_station
    @end_station = end_station
    @intermediate = intermediate
  end

  def delete_station(name)
    if stations.include?(name)
      stations.delete(name)
    else
      puts "#{name} - There is no such station"
    end
  end

  def stations
    return [@start_station, *@intermediate, @end_station]
  end
end