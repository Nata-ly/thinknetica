#frozen_string_literal: true

module WagonInterface
  private

  def work_with_wagons
    loop do
      puts '1 - добавить вагон'
      puts '2 - занять место/ объем в вагоне'
      puts 'stop или 0 - назад'
      case gets.chomp
      when '1'
        add_wagon
      when '2'
        begin
          wagon = choose_wagon(true, true)
          if wagon.class == TextInterface::WAGON_TYPE[1]
            puts 'Введите количество груза:'
            wagon.take_place_of(gets.chomp.to_i)
          else
            wagon.take_place_of
          end
          puts 'Место занято'
        rescue StandardError => e
          puts "Груз не был добавлен. #{e.message}."
        end
      when 'stop', '0'
        break
      end
    end
  end
end
