require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'freight_carriage'
require_relative 'passenger_carriage'
require_relative 'carriage'
require_relative 'route'
require_relative 'station'
require_relative 'loger'

# simulates the operation of the program
class Simulation
  def initialize
    @stations = []
    @current_train = nil
    @route = nil
    @trains = []
    @type = ''
  end

  def start
    start_log
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
      awt_log
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
      case @type
      when 'CARGO'
        @current_train = TrainCargo.new(number)
        if @current_train.valid?
          @trains << @current_train
        else
          er_name_error
        end
      when 'PASSENGER'
        @current_train = TrainPassenger.new(number)
        if @current_train.valid?
          @trains << @current_train
        else
          er_name_error
        end
      end
      next if @current_train.nil?
      @current_train.appoint_route(@route)
      puts 'The route for the train is set'
      train_actions
    end
  end

  def train_actions
    loop do
      ta_log
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
      ftr_log
      answer = gets.to_i
      case answer
      when 1
        if @current_train.current_station.name_station != @current_train.route.last.name_station
          @current_train.move(1)
        else
          puts 'You have already arrived at your destination'
        end
      when 2
        if @current_train.current_station.name_station != @current_train.route.first.name_station
          @current_train.move(-1)
        else
          puts 'You are already at the starting point of the route'
        end
      when 3
        @current_train.current_station.all_trains { |train| puts train.type }
      when 0
        start
      end
    end
  end

  def action_with_carriages
    loop do
      awc_log
      answer = gets.to_i
      case answer
      when 1
        attach_carriage
      when 2
        @current_train.unhook_carriage
      when 3
        @current_train.carriages.each do |carriage|
          puts "Type: #{carriage.type}, capacity: #{carriage.show_capacity}, occupied: #{carriage.show_occupied_volume}"
        end
      when 4
        fill_capacity
      when 0
        train_actions
      end
    end
  end

  def attach_carriage
    puts 'What is the capacity of the carriage?'
    if @type == 'CARGO'
      capacity = gets.to_i
      @current_train.hit_the_brake
      @current_train.attach_carriage(FreigtCarriage.new(capacity))
    elsif @type == 'PASSENGER'
      seats = gets.to_i
      @current_train.hit_the_brake
      @current_train.attach_carriage(PassengerCarriage.new(seats))
    end
  end

  def fill_capacity
    if @type == 'PASSENGER'
      @current_train.carriages.last.loading
    elsif @type == 'CARGO'
      puts 'Enter the amount to fill'
      amount_fill = gets.to_i
      @current_train.carriages.last.loading(amount_fill)
    end
  end

  def find_train(number)
    value = nil
    @trains.each do |train|
      value = train if train.number == number
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
      way << station.name_station unless station.nil?
    end
    puts "Your way: #{way}"
  end

  def er_name_error
  puts 'NameError try again'
  @current_train = nil
  actions_with_trains
  end
end

simulation = Simulation.new
simulation.start