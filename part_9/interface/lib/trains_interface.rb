# frozen_string_literal: true

# Module that implements work with the trains menu section.
module TrainsInterface
  FORMATERS_TRAINS = {
    1 => ->(context) { context.show_trains },
    2 => ->(context) { context.add_route_to_train },
    3 => ->(context) { context.add_wagon_to_train },
    4 => ->(context) { context.delete_wagons_from_train },
    5 => ->(context) { context.train_move_next },
    6 => ->(context) { context.train_move_past },
    7 => ->(context) { context.add_train },
    8 => ->(context) { context.show_train_wagons }
  }.freeze

  def work_with_trains
    loop do
      display_menu_trains
      format = gets.chomp
      break if %w[0 stop].include?(format)

      FORMATERS_TRAINS[format.to_i].call(self)
    end
  end

  def display_menu_trains
    puts 'Выберите действие:'
    puts '1 - вывести существующие поезда'
    puts '2 - назначить маршрут поезду'
    puts '3 - добавить вагон'
    puts '4 - отцепить вагон'
    puts '5 - двигаться вперед'
    puts '6 - двигаться назад'
    puts '7 - добавить поезд'
    puts '8 - вывести список вагонов'
    puts '0 или stop - назад'
  end

  def train_move_next
    puts choose_train.move_next_station
  end

  def train_move_past
    puts choose_train.move_past_station
  end

  def show_train_wagons
    choose_train.each_wagons_list { |car| puts car.to_s }
  end

  def add_wagon_to_train
    train = choose_train
    wagon = choose_wagon
    puts train.add_wagons(wagon)
  rescue StandardError => e
    puts "Вагон не был добавлен. #{e.message}."
  end

  def add_route_to_train
    train = choose_train
    route = choose_route
    train.add_route(route)
    puts 'Маршрут добавлен'
  end

  def show_trains
    choose_type(TextInterface::TRAIN_TYPE).all.each { |train| puts train.to_s }
  end

  def delete_wagons_from_train
    train = choose_train
    wagon = choose_wagon
    puts train.delete_wagons(wagon)
  end
end
