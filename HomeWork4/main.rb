require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'freight_carriage'
require_relative 'passenger_carriage'
require_relative 'carriage'
require_relative 'route'
require_relative 'station'

class Simulation
  def initialize
    @train = nil
    @route = Route.new(nil, nil)
    @trains = []
    @type_carriage = ''
  end

  def start
    puts '1: Route actions'
    puts '2: Actions with trains'
    puts '0: Exit programm'
    answer = gets.to_i
    if answer == 1
      action_with_route
    elsif answer == 2
      action_with_train
    end
  end


  def action_with_route
    while true
    puts '1: Add station'
    puts '2: Delete station'
    puts '0: Exit'
    answer = gets.to_i
    if answer == 1
      while true
        puts '1: Change the start station'
        puts '2: Change the end station'
        puts '3: Add intermediate station'
        puts '0: Exit'
        answer2 = gets.to_i
        if answer2 == 1
          puts 'Enter a new station name:'
          new_name = gets.chomp
          @route.change_start_station(new_name)
          way
        elsif answer2 == 2
          puts 'Enter a new station name:'
          new_name = gets.chomp
          @route.change_end_station(new_name)
          way
        elsif answer2 == 3
          puts 'Enter a new station name:'
          new_name = gets.chomp
          @route.add_intermediate_station(new_name)
          way
        elsif answer2 == 0
          break
        end
      end
    elsif answer == 2
      puts 'Kakaya stanciya dolzjna bit udalena?'
      puts '1: Start station'
      puts '2: End station'
      puts '3: Intermediate station'
      puts '0: Exit'
      answer2 = gets.to_i
      if answer2 == 1
        @route.delete_start_station
      elsif answer2 == 2
        @route.delete_end_station
      elsif answer2 == 3
        puts 'Napishi imya stancii'
        name = gets.chomp
        @route.delete_intermediate_station(name)
      elsif answer2 == 0
        next
      end
      way
    elsif answer == 0
      start
    end
    end
  end

  def action_with_train
    puts 'Create a train by entering the train number and the type of which the route will be set'
    number = gets.chomp
    @type = gets.chomp.upcase
    if @type == 'CARGO'
      @train = TrainCargo.new(number)
    elsif @type == 'PASSENGER'
      @train = TrainPassenger.new(number)
    end
    if @route != nil
      @train.set_route(@route)
      puts 'The route for the train is set'
    end
    while true
      puts 'Would you like to regulate the wagons on the current train?'
      puts '1: Yes'
      puts '0: Exit'
      answer = gets.to_i
      if answer == 1
        puts '1: Attach carriages'
        puts '2: Disconnect carriages'
        puts '0: Exit'
        answer2 = gets.to_i
        if answer2 == 1
          if @type == 'CARGO'
            @train.hit_the_brake
            @train.attach_carriage(FreigtCarriage.new)
          elsif @type == 'PASSENGER'
            @train.hit_the_brake
            @train.attach_carriage(PassengerCarriage.new)
          end
        elsif answer2 == 2
          @train.hit_the_brake
          @train.unhook_carriage(@train.train_composition.last)
        elsif answer2 == 0
          start
        end
      elsif answer == 0
        break
      end
    end
    puts 'Choose where to send the train:'
    puts '1: Next'
    puts '2: Previos'
    puts '0: End route'
    answer = gets.to_i
    if answer == 1
      @train.move_next
    elsif answer == 2
      @train.move_previos
    elsif answer == 0
      start
    end
  end

  private

  def way
    way = []
    @route.stations.each do |station| 
      if station != nil 
        way << station.name_station
      end
    end
    puts "Your way: #{way}"
  end
end

simulation = Simulation.new
simulation.start