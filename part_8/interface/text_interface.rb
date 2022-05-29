# frozen_string_literal: true

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require_relative file }

class TextInterface
  ATTEMPTS_ADD_TRAIN = 3
  TRAIN_TYPE = { 1 => CargoTrain, 2 => PassengerTrain }
  WAGON_TYPE = { 1 => CargoWagon, 2 => PassengerWagon }

  include AdditionalMethods, RoutesInterface, Seed, StationsInterface, TrainsInterface, WagonInterface

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
end
