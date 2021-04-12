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
    @start_station = nil
    @end_station = nil
    @intermediate_station = nil
    @current_train = nil
    @route = nil #Route.new(nil, nil)
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
      actions_with_trains
    end
  end

  private

  def action_with_route
    loop do
      puts '1: Add station'
      puts '2: Delete station'
      puts '0: Exit'
      answer = gets.to_i
      case answer
      when 1
        change_station
      when 2
        delete_station
      when 0
        start
      end
    end
  end


  def change_station
    loop do
      puts '1: Change the start station'
      puts '2: Change the end station'
      puts '3: Add intermediate station'
      puts '0: Exit'
      answer = gets.to_i
      case answer
      when 1
        puts 'Enter a new station name:'
        new_name = gets.chomp
        @start_station = Station.new(new_name)
        way
      when 2
        puts 'Enter a new station name:'
        new_name = gets.chomp
        @end_station = Station.new(new_name)
        way
      when 3
        puts 'Enter a new station name:'
        new_name = gets.chomp
        @intermediate_station = Station.new(new_name)
        way
      when 0
        @route = Route.new(@start_station, @end_station, @intermediate_station)
        action_with_route
      end
    end
  end

  def delete_station
    loop do
      puts 'Which station is dolzjna bit udalena?'
      puts '1: Intermediate station'
      puts '0: Exit'
      answer = gets.to_i
      case answer
      when 1
        puts 'Enter name station'
        name = gets.chomp
        @route.delete_station(name)
        way
      when 0
        action_with_route
      end
    end
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
      end
    end
  end

  def create_train
    puts 'Create a train by entering the train number and the type of which the route will be set'
    number = gets.chomp
    @type = gets.chomp.upcase
    if @type == 'CARGO'
      @current_train = TrainCargo.new(number)
      @trains << @current_train
    elsif @type == 'PASSENGER'
      @current_train = TrainPassenger.new(number)
      @trains << @current_train
    end
    if @route != nil
      @current_train.set_route(@route)
      puts 'The route for the train is set'
    end
    train_actions
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
        @current_train.move_next
      when 2
        @current_train.move_previos
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
        if @type == 'CARGO'
          @current_train.hit_the_brake
          @current_train.attach_carriage(FreigtCarriage.new)
        end
      when 2
        if @type == 'PASSENGER'
          @current_train.hit_the_brake
          @current_train.attach_carriage(PassengerCarriage.new)
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

 def way
    way = []
    [@start_station, *@intermediate, @end_station].each do |station| 
      if station != nil 
        way << station.name_station
      end
    end
    puts "Your way: #{way}"
  end
end

simulation = Simulation.new
simulation.start