class Rout
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
		puts @way.unshift(@start_station).push(@end_station)
	end
end

rout = Rout.new('Volga', 'NeVolga')
rout.add_intermediate_station('Intermediate station')
rout.delete_station('AIKJHNF')
rout.show_stations