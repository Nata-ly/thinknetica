#frozen_string_literal: true

module AdditionalMethods
  private

  def choose_train(message = false, choice = false)
    type = choose_type(TextInterface::TRAIN_TYPE)
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
    type = choose_type(TextInterface::WAGON_TYPE)
    raise 'Сперва создайте вагон' if type.instances.nil?
    puts 'Выберите вагон' if message == true
    type.all.each_with_index { |wagon, index| puts "#{index + 1} - #{wagon.number}" }
    type.all[gets.chomp.to_i - 1] if choice == true
  end

  def choose_station(message = false, choice = false)
    puts 'Выберите станцию' if message == true
    raise 'Сперва создайте станцию' if Station.instances.nil?
    Station.all.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
    Station.all[gets.chomp.to_i - 1] if choice == true
  end

  def choose_type(list)
    puts 'Выберите тип:'
    list.each { |key, value| puts "#{key} - #{value.name}" }
    raise 'Выбран неверный тип' if (type = list[gets.chomp.to_i]).nil?
    type
  end

  def add_train
    attempts = 0
    begin
      attempts += 1
      type = choose_type(TextInterface::TRAIN_TYPE)
      puts 'Введите название:'
      type.new(gets.chomp)
      puts 'Поезд добавлен'
    rescue StandardError => e
      puts "Поезд не был добавлен. #{e.message}."
      puts "Осталось попыток - #{TextInterface::ATTEMPTS_ADD_TRAIN - attempts}" if attempts <= TextInterface::ATTEMPTS_ADD_TRAIN
      retry if attempts <= TextInterface::ATTEMPTS_ADD_TRAIN
    end
  end

  def add_wagon
    type = choose_type(TextInterface::WAGON_TYPE)
    puts 'Введите номер вагона'
    number = gets.chomp
    puts "Введите #{type == TextInterface::WAGON_TYPE[1] ? 'доступный объем' : 'количество мест'}"
    capacity = gets.chomp.to_i
    type.new(number, capacity)
    puts 'Вагон добавлен'
  rescue StandardError => e
    puts "Вагон не был добавлен. #{e.message}."
  end
end
