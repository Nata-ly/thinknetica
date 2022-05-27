# frozen_string_literal: true

class TextInterface
  ATTEMPTS_ADD_TRAIN = 3
  TRAIN_TYPE = { 1 => CargoTrain, 2 => PassengerTrain}

  def call
    loop do
      puts "\n"
      puts 'Выберите действие:'
      puts '1 - станции'
      puts '2 - поезда'
      puts '3 - маршруты'
      puts '4 - вагоны'
      puts '5 - seed'
      puts '0 или stop - выход'
      case gets.chomp.to_s
      when '1'
        work_with_stations
      when '2'
        work_with_trains
      when '3'
        work_with_routes
      when '4'
        work_with_wagons
      when '5'
        seed
      when 'stop', '0'
        break
      end
    end
  end

  private

  def seed
    train1 = CargoTrain.new('train1')
    train2 = CargoTrain.new('train2')
    train3 = PassengerTrain.new('train3')
    puts "Созданы поезда #{train1}, #{train2}, #{train3}"

    station1 = Station.new('station1')
    station2 = Station.new('station2')
    station3 = Station.new('station3')
    station4 = Station.new('station4')
    station5 = Station.new('station5')
    station6 = Station.new('station6')
    puts 'Созданы станции 1-6'

    route1 = Route.new(station1, station6)
    route2 = Route.new(station2, station5)
    puts 'Созданы маршруты 1-2'

    wagons1 = CargoWagon.new('Cargo - 1')
    wagons2 = PassegerWagon.new('Passenger - 1')
  end

  def work_with_stations
    loop do
      puts "\n"
      puts 'Выберите действие:'
      puts '1 - вывести существующие станции'
      puts '2 - вывести список поездов на станции'
      puts '3 - создать новую станцию'
      puts '0 или stop - назад'
      case gets.chomp.to_s
      when '1'
        choose_station
      when '2'
        choose_station(true, true).print_train_list
      when '3'
        puts 'Введите название:'
        Station.new(gets.chomp)
        puts 'Станция добавлена'
      when 'stop', '0'
        break
      end
    end
  end

  def choose_train(message = false, choice = false)
    type = choose_type_train
    puts 'Выберите поезд' if message == true
    type.all.each_with_index { |train, index| puts "#{index + 1} - #{train.number} - #{train.type}" }
    type.all[gets.chomp.to_i - 1] if choice == true
  end

  def choose_route(message = false, choice = false)
    puts 'Выберите маршрут' if message == true
    Route.all.each_with_index { |route, index| puts "#{index + 1} - #{route}" }
    Route.all[gets.chomp.to_i - 1] if choice == true
  end

  def choose_wagon(message = false, choice = false)
    puts 'Выберите вагон' if message == true
    Wagon.all.each_with_index { |wagon, index| puts "#{index + 1} - #{wagon.number}" }
    Wagon.all[gets.chomp.to_i - 1] if choice == true
  end

  def choose_station(message = false, choice = false)
    puts 'Выберите станцию' if message == true
    Station.all.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
    Station.all[gets.chomp.to_i - 1] if choice == true
  end

  def choose_type_train
    puts 'Выберите тип:'
    TRAIN_TYPE.each { |key, value| puts "#{key} - #{value.name}" }
    raise 'Выбран неверный тип' if (type = TRAIN_TYPE[gets.chomp.to_i]).nil?
    type
  end

  def add_train
    attempts = 0
    begin
      attempts += 1
      type = choose_type_train
      puts 'Введите название:'
      type.new(gets.chomp)
      puts 'Поезд добавлен'
    rescue => e
      puts "Поезд не был добавлен. #{e.message}"
      retry if attempts <= ATTEMPTS_ADD_TRAIN
    end
  end

  def work_with_trains
    loop do
      puts "\n"
      puts 'Выберите действие:'
      puts '1 - вывести существующие поезда'
      puts '2 - назначить маршрут поезду'
      puts '3 - добавить вагон'
      puts '4 - отцепить вагон'
      puts '5 - двигаться вперед'
      puts '6 - двигаться назад'
      puts '7 - добавить поезд'
      puts '0 или stop - назад'
      case gets.chomp.to_s
      when '1'
        choose_train
      when '2'
        train = choose_train(true, true)
        route = choose_route(true, true)
        train.add_route(route)
        puts 'Маршрут добавлен'
      when '3'
        train = choose_train(true, true)
        wagon = choose_wagon(true, true)
        puts train.add_wagons(wagon)
      when '4'
        train = choose_train(true, true)
        wagon = choose_wagon(true, true)
        puts train.delete_wagons(wagon)
      when '5'
        puts choose_train(true, true).move_next_station
      when '6'
        puts choose_train(true, true).move_past_station
      when '7'
        add_train
      when 'stop', '0'
        break
      end
    end
  end

  def work_with_wagons
    loop do
      puts '1 - добавить вагон'
      puts 'stop или 0 - назад'
      case gets.chomp
      when '1'
        puts 'Выберите тип вагона: 1 - грузовой, 2 - пассажирский'
        type = gets.chomp
        puts 'Введите номер вагона'
        number = gets.chomp
        if type == '1'
          CargoWagon.new(number)
          puts 'Вагон добавлен'
        elsif type == '2'
          PassegerWagon.new(number)
          puts 'Вагон добавлен'
        else
          puts 'Неверный тип вагона'
        end
      when 'stop', '0'
        break
      end
    end
  end

  def work_with_routes
    loop do
      puts "\n"
      puts 'Выберите действие:'
      puts '1 - добавить маршрут'
      puts '2 - добавить станцию в маршрут'
      puts '3 - удалить станцию из маршрута'
      puts '4 - вывести станции маршрута'
      puts '0 или stop - назад'

      case gets.chomp.to_s
      when '1'
        puts 'Введите начальную станцию'
        station1 = choose_station(true, true)
        puts 'Введите конечную станцию'
        station2 = choose_station(true, true)
        Route.new(station1, station2)
        puts 'Маршрут добавлен'
      when '2'
        route = choose_route(true, true)
        station = choose_station(true, true)
        route.add_station(station)
      when '3'
        route = choose_route(true, true)
        station = choose_station(true, true)
        route.delete_station(station)
      when '4'
        route = choose_route(true, true)
        puts route.print_station_list
      when 'stop', '0'
        break
      end
    end
  end
end
