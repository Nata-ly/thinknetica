# frozen_string_literal: true

# Module that implements work with the routes menu section.
module RoutesInterface
  FORMATERS_ROUTES = {
    1 => ->(context) { context.add_route },
    2 => ->(context) { context.add_station_to_route },
    3 => ->(context) { context.delete_station_from_route },
    4 => ->(context) { context.show_route_stations }
  }.freeze

  def work_with_routes
    loop do
      display_menu_routes
      format = gets.chomp
      break if %w[0 stop].include?(format)

      FORMATERS_ROUTES[format.to_i].call(self)
    end
  end

  def display_menu_routes
    puts "\n"
    puts 'Выберите действие:'
    puts '1 - добавить маршрут'
    puts '2 - добавить станцию в маршрут'
    puts '3 - удалить станцию из маршрута'
    puts '4 - вывести станции маршрута'
    puts '0 или stop - назад'
  end

  def add_route
    puts 'Введите начальную станцию'
    station1 = choose_station
    puts 'Введите конечную станцию'
    station2 = choose_station
    Route.new(station1, station2)
    puts 'Маршрут добавлен'
  end

  def add_station_to_route
    route = choose_route
    station = choose_station
    route.add_station(station)
  rescue StandardError => e
    puts e.message
  end

  def delete_station_from_route
    route = choose_route
    station = choose_station
    route.delete_station(station)
  end

  def show_route_stations
    puts choose_route.print_station_list
  end
end
