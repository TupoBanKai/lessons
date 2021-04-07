require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'freight_carriage'
require_relative 'passenger_carriage'
require_relative 'carriage'
require_relative 'route'
require_relative 'station' # ИСПРАВИТЬ ПРЕДИДУЩЕЕ ЗАДАНИЕ НА ГИТХАБЕ

class Simulation
  def initialize
    @train = nil
    @route = Route.new(nil, nil)
    @trains = []
    @type_carriage = ''
  end

  def start # ПОЧЕМУ ТО НЕ ПРИНИМАЕТ BREAK ПОД 0 ОТВЕТОМ ДЛЯ ВЫХОДА
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
    puts 'Создайте поезд введя номер поезда и тип которому задастся маршрут'
    number = gets.chomp
    @type = gets.chomp.upcase
    if @type == 'CARGO'
      @train = TrainCargo.new(number)
    elsif @type == 'PASSENGER'
      @train = TrainPassenger.new(number)
    end
    if @route != nil
      @train.set_route(@route)
      puts 'Маршрут для поезда задан'
    end
    while true
      puts 'Желаете ли вы регулировать вагонами на текущем поезде?'
      puts '1: Да'
      puts '0: Exit'
      answer = gets.to_i
      if answer == 1
        puts '1: Присоединить вагоны'
        puts '2: Отсоединить вагоны'
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
    puts 'Viberite kuda otpravit poezd:'
    puts '1: fpered'
    puts '2: nasat'
    puts '0: End route' # ОПЯТЬ BREAK не работает
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