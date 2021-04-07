class Station
  attr_reader :station_type_trains, :name_station

  def initialize(name_station)
    @name_station = name_station
    @station_type_trains = {'Cargo' => [], 'Pasenger' => []}
  end

  def show_trains
    puts @station_type_trains['Cargo'].map { |train| "#{train.type} #{train.number}" }
    puts @station_type_trains['Pasenger']
    puts "Cargo's count = #{@station_type_trains['Cargo'].count}"
    puts "Pasenger's count = #{@station_type_trains['Pasenger'].count}"
  end 

  # private

  def receiving_trains(train)
    items = @station_type_trains[train.type]
    items << train
    @station_type_trains[train.type] = items
  end

  def sending_trains(train)
    @station_type_trains[train.type].delete(train)
  end
end