class Station
	$current_trains = []
	$station_type_trains = {}
	attr_reader :current_trains, :station_type_trains

	def initialize(name_station)
		@name_station = name_station
		@throughput = 1
	end

	def receiving_trains(train_type, status)
		if status == 'Arrived'
			$current_trains << train_type
			$station_type_trains[train_type] = $station_type_trains[train_type].to_i + 1
			puts "#{train_type} - #{status}"
		elsif status == 'Did not arrive'
			puts 'Train is not at the station yet'
		else
			puts "#{status} - invalid status"
		end
	end

	def sending_trains
		$current_trains[0, @throughput].each do |train| 
			$current_trains.delete(train)
			puts "#{train} - Sended"
		end
	end
end

class Train
	attr_reader :this_train_is
	attr_accessor :status

	def initialize
		@train_type = ['Branded', 'Swift', 'Passenger', 'Compartment car']
		@this_train_is = @train_type[rand(0..3)]
		@status = 'Did not arrive'
	end
end

station = Station.new('Volga')
train = Train.new
train2 = Train.new
train3 = Train.new
station.receiving_trains(train.this_train_is, 'Arrived')
station.receiving_trains(train2.this_train_is, 'Arrived')
station.receiving_trains(train3.this_train_is, 'Arrived')
station.sending_trains