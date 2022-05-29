#frozen_string_literal: true

module StationsInterface
  private

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
        choose_station(true, true).each_trains_list { |train| puts "#{train.number}: тип #{train.type}, кол-во вагонов #{train.list_wagons.size}"}
      when '3'
        puts 'Введите название:'
        Station.new(gets.chomp)
        puts 'Станция добавлена'
      when 'stop', '0'
        break
      end
    end
  end
end
