class Station
  attr_reader :station_type_trains, :name_station

  def initialize(name_station)
    @name_station = name_station
    @station_type_trains = {:cargo => [], :passenger => []}
    @@all.append(self)
  end

  def show_trains
    return @station_type_trains
  end 

  # private
  @@all = []

  def self.all
    @@all
  end

  def receiving_trains(train)
    items = @station_type_trains[train.type]
    items << train
    @station_type_trains[train.type] = items
  end

  def sending_trains(train)
    @station_type_trains[train.type].delete(train)
  end
end