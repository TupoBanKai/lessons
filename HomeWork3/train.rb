class Train
	attr_reader :speed, :carriages

	def initialize(number, type, carriages)
		@number = number
		@type = type
		@carriages = carriages
		@speed = 0
	end

	def take_overclocking
		if @type == 'Passangers'
			puts @speed = 80
		elsif @type == 'Cargo'
			puts @speed = 60
		end
	end

	def hit_the_brake
		puts @speed = 0
	end

	def attach_carriage
		puts @carriages += 1
	end

	def unhook_carriage
		puts @carriages -= 1
	end

	def departure(rout)
		puts "Train went on the route - #{rout}"
	end
end

class Rout #тот же класс, что и в файле rout.rb
	def initialize(start_station, end_station)
		@start_station = start_station
		@end_station = end_station
		@way = []
	end

	def add_intermediate_station(name)
		@way << name
	end

	def delete_station(name)
		if @way.include?(name)
			@way.delete(name)
		else
			puts "#{name} - There is no such station"
		end
	end

	def show_stations
		@way.unshift(@start_station).push(@end_station)
	end
end

train = Train.new(1, 'Cargo', 10)
rout = Rout.new('Volga', 'NeVolga')
train.take_overclocking
train.hit_the_brake
train.attach_carriage
train.carriages
train.departure(rout.show_stations)