# frozen_string_literal: true

# Module that implements work with the station menu section.
module StationsInterface
  FORMATERS_STATIONS = {
    1 => ->(context) { context.print_stations },
    2 => ->(context) { context.print_trains_to_stations },
    3 => ->(context) { context.add_new_station }
  }.freeze

  def work_with_stations
    loop do
      display_menu_stations
      format = gets.chomp
      break if %w[0 stop].include?(format)

      FORMATERS_STATIONS[format.to_i].call(self)
    end
  end

  def display_menu_stations
    puts "\n"
    puts 'Выберите действие:'
    puts '1 - вывести существующие станции'
    puts '2 - вывести список поездов на станции'
    puts '3 - создать новую станцию'
    puts '0 или stop - назад'
  end

  def add_new_station
    puts 'Введите название:'
    Station.new(gets.chomp)
    puts 'Станция добавлена'
  end

  def print_trains_to_stations
    choose_station.each_trains_list { |train| puts train.to_s }
  end
end
