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
    @stations = []
    @current_train = nil
    @route = nil
    @trains = []
    @type_carriage = ''
  end

  def start
    puts '1: Route actions'
    puts '2: Actions with trains'
    puts '0: Exit programm'
    answer = gets.to_i
    if answer == 1
      change_station
    elsif answer == 2
      actions_with_trains
    end
  end

  private

  def change_station
    puts 'Change the start station'
    create_station
    puts 'Add intermediate station'
    create_station
    puts 'Change the end station'
    create_station
    start_station = @stations[0]
    end_station = @stations[-1]
    @route = Route.new(start_station, end_station, @stations[1, -2])
    actions_with_trains
  end

  def actions_with_trains
    loop do
      puts '1: Create a train'
      puts '2: Select existing'
      puts '0: Exit'
      answer = gets.to_i
      case answer
      when 1
        create_train
      when 2
        puts 'Enter the number of the train'
        find_train(gets.chomp)
      when 0
        exit
      end
    end
  end

  def create_train
    loop do
      puts 'Create a train by entering the train number and the type of which the route will be set'
      number = gets.chomp
      @type = gets.chomp.upcase
      if @type == 'CARGO'
        @current_train = TrainCargo.new(number)
        if @current_train.valid? 
          @trains << @current_train
        else
          puts 'NameError try again'
          @current_train = nil
          actions_with_trains
        end
      end
      if @type == 'PASSENGER'
        @current_train = TrainPassenger.new(number)
        if @current_train.valid? 
          @trains << @current_train
        else
          puts 'NameError try again'
          @current_train = nil
          actions_with_trains
        end
      end
      if @current_train != nil
        @current_train.set_route(@route)
        puts 'The route for the train is set'
        train_actions
      end
    end
  end

  def train_actions
    loop do
      puts '1: Follow the route'
      puts '2: Actions with carriages'
      puts '0: Exit'
      answer = gets.to_i
      case answer
      when 1
        follow_the_ruote
      when 2
        action_with_carriages
      when 0
        actions_with_trains
      end
    end
  end

  def follow_the_ruote
    loop do
      puts 'Choose where to send the train:'
      puts '1: Next'
      puts '2: Previos'
      puts '0: End route'
      answer = gets.to_i
      case answer
      when 1
        if @current_train.current_station != @current_train.route.last.name_station
          @current_train.move(1)
        else
          puts 'You have already arrived at your destination'
        end
      when 2
        if @current_train.current_station != @current_train.route.first.name_station
          @current_train.move(-1)
        else
          puts 'You are already at the starting point of the route'
        end
      when 0
        start
      end
    end
  end

  def action_with_carriages
    loop do
      puts '1: Attach carriages'
      puts '2: Disconnect carriages'
      puts '0: Exit'
      answer = gets.to_i
      case answer
      when 1
        if @type == :cargo
          @current_train.hit_the_brake
          @current_train.attach_carriage(FreigtCarriage.new)
          @current_train.carriages.each { |carriage| puts "#{type.carriage}" }
        end
      when 2
        if @type == :passenger
          @current_train.hit_the_brake
          @current_train.attach_carriage(PassengerCarriage.new)
          @current_train.carriages.each { |carriage| puts "#{type.carriage}" }
        end
      when 0
        train_actions
      end
    end
  end

  def find_train(number)
    value = nil
    @trains.each do |train| 
      if train.number == number
        value = train
      end
    end
    @current_train = @trains[@trains.find_index(value)]
    train_actions
 end

 def create_station
  puts 'Enter a new station name:'
    new_name = gets.chomp
    @stations << Station.new(new_name)
    way
 end

 def way
    way = []
    @stations.each do |station| 
      if station != nil 
        way << station.name_station
      end
    end
    puts "Your way: #{way}"
  end
end

simulation = Simulation.new
simulation.start