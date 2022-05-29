#frozen_string_literal: true

module RoutesInterface
  private

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
        begin
          route = choose_route(true, true)
          station = choose_station(true, true)
          route.add_station(station)
        rescue StandardError => e
          puts "#{e.message}."
        end
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
