# frozen_string_literal: true

# Module that implements work with the wagons menu section.
module WagonsInterface
  private

  FORMATERS_WAGONS = {
    1 => ->(context) { context.send(:add_wagon) },
    2 => ->(context) { context.send(:take_seat_wagon) }
  }.freeze

  def work_with_wagons
    loop do
      display_menu_wagons
      format = gets.chomp
      break if %w[0 stop].include?(format)

      FORMATERS_WAGONS[format.to_i].call(self)
    end
  end

  def display_menu_wagons
    puts '1 - добавить вагон'
    puts '2 - занять место/ объем в вагоне'
    puts 'stop или 0 - назад'
  end

  def take_seat_wagon
    wagon = choose_wagon
    if wagon.instance_of?(TextInterface::WAGON_TYPE[1])
      puts 'Введите количество груза:'
      wagon.take_place_of(gets.chomp.to_i)
    else
      wagon.take_place_of
    end
    puts 'Место занято'
  rescue StandardError => e
    puts "Груз не был добавлен. #{e.message}"
  end
end
