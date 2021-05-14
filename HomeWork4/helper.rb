# frozen_string_literal: true

require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'freight_carriage'
require_relative 'route'
require_relative 'station'
require_relative 'passenger_carriage'

# helper class for main.rb class simulatuin
class Helper
  attr_accessor :stations, :current_train, :route, :trains

  def initialize
    @stations = []
    @current_train = nil
    @route = nil
    @trains = []
    @number = nil
  end

  def create_train
    puts 'Create a train by entering the train number and the type of which the route will be set'
    @number = gets.chomp
    @type = gets.chomp.upcase
    case @type
    when 'CARGO'
      create_cargo
    when 'PASSENGER'
      create_passenger
    end
    @current_train.appoint_route(@route)
  end

  def create_cargo
    @current_train = TrainCargo.new(@number)
    if @current_train.valid?
      @trains << @current_train
    else
      er_name_error
    end
  end

  def create_passenger
    @current_train = TrainPassenger.new(@number)
    if @current_train.valid?
      @trains << @current_train
    else
      er_name_error
    end
  end

  def er_name_error
    puts 'NameError try again'
    @current_train = nil
    actions_with_trains
  end

  def way
    way = []
    @stations.each do |station|
      way << station.name_station unless station.nil?
    end
    puts "Your way: #{way}"
  end

  def create_station
    puts 'Enter a new station name:'
    new_name = gets.chomp
    @stations << Station.new(new_name)
    way
  end

  def find_train(number)
    value = nil
    @trains.each do |train|
      value = train if train.number == number
    end
    @current_train = @trains[@trains.find_index(value)]
    train_actions
  end

  def fill_capacity
    case @type
    when 'PASSENGER'
      @current_train.carriages.last.loading
    when 'CARGO'
      puts 'Enter the amount to fill'
      amount_fill = gets.to_i
      @current_train.carriages.last.loading(amount_fill)
    end
  end

  def attach_carriage
    puts 'What is the capacity of the carriage?'
    case @type
    when 'CARGO'
      capacity = gets.to_i
      @current_train.attach_carriage(FreigtCarriage.new(capacity))
    when 'PASSENGER'
      seats = gets.to_i
      @current_train.attach_carriage(PassengerCarriage.new(seats))
    end
  end
end
