#frozen_string_literal: true

module TrainsInterface
  private

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
      puts '8 - вывести список вагонов'
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
        begin
          train = choose_train(true, true)
          wagon = choose_wagon(true, true)
          puts train.add_wagons(wagon)
        rescue StandardError => e
          puts "Вагон не был добавлен. #{e.message}."
        end
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
      when '8'
        choose_train(true, true).each_wagons_list { |wagon| puts "#{wagon.number} - #{wagon.type}: св. #{wagon.free_places}, з. #{wagon.busy}" }
      when 'stop', '0'
        break
      end
    end
  end
end
