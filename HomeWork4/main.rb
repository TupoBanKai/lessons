# frozen_string_literal: true

require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'freight_carriage'
require_relative 'passenger_carriage'
require_relative 'carriage'
require_relative 'route'
require_relative 'station'
require_relative 'loger'
require_relative 'helper'

# simulates the operation of the program
class Simulation
  def initialize
    @type = ''
    @loger = Log.new
    @helper = Helper.new
  end

  def start
    @loger.start_log
    answer = gets.to_i
    case answer
    when 1
      change_station
    when 2
      actions_with_trains
    end
  end

  private

  def change_station
    puts 'Change the start station'
    @helper.create_station
    puts 'Add intermediate station'
    @helper.create_station
    puts 'Change the end station'
    @helper.create_station
    @helper.route = Route.new(@helper.stations[0], @helper.stations[-1], @helper.stations[1, -2])
    actions_with_trains
  end

  def actions_with_trains
    @loger.awt_log
    answer = gets.to_i
    case answer
    when 1
      @helper.create_train
      train_actions
    when 2
      puts 'Enter the number of the train'
      @helper.find_train(gets.chomp)
    end
  end

  def train_actions
    @loger.ta_log
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

  def follow_the_ruote
    return unless @helper.current_train.current_station.name_station != @helper.current_train.route.last.name_station
      @loger.ftr_log
      answer = gets.to_i
      case answer
      when 1
        move_train
      when 2
        @helper.current_train.current_station.all_trains { |train| puts train.type }
      end
    end
  end

  def move_train
    @loger
      .answer = gets.to_i
    case answer
    when 1
      @helper.current_train.move(1)
    when 2
      @helper.current_train.move(-1)
    when 3
      follow_the_ruote
    end
  end

  def action_with_carriages
    @loger.awc_log
    answer = gets.to_i
    case answer
    when 1
      @helper.attach_carriage
    when 2
      create_carriage
    when 3
      @helper.fill_capacity
    end
  end

  def create_carriage
    @loger.cc_log
    answer = gets.to_i
    case answer
    when 1
      @helper.current_train.unhook_carriage
    when 2
      @helper.current_train.carriages.each do |carriage|
        puts "Type: #{carriage.type}, capacity: #{carriage.show_capacity}, occupied: #{carriage.show_occupied_volume}"
      end
    end
  end
end

simulation = Simulation.new
simulation.start
