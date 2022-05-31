# frozen_string_literal: true

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require_relative file }

class TextInterface
  include AdditionalMethods
  include RoutesInterface
  include Seed
  include StationsInterface
  include TrainsInterface
  include WagonsInterface

  ATTEMPTS_ADD_TRAIN = 3

  TRAIN_TYPE = {
    1 => CargoTrain,
    2 => PassengerTrain
  }.freeze

  WAGON_TYPE = {
    1 => CargoWagon,
    2 => PassengerWagon
  }.freeze

  FORMATERS = {
    1 => ->(context) { context.send(:work_with_stations) },
    2 => ->(context) { context.send(:work_with_trains) },
    3 => ->(context) { context.send(:work_with_routes) },
    4 => ->(context) { context.send(:work_with_wagons) },
    5 => ->(context) { context.send(:seed) }
  }.freeze

  def call
    loop do
      display_menu
      format = gets.chomp
      break if %w[0 stop].include?(format)

      FORMATERS[format.to_i].call(self)
    end
  end

  def display_menu
    puts "\n"
    puts 'Выберите действие:'
    puts '1 - станции'
    puts '2 - поезда'
    puts '3 - маршруты'
    puts '4 - вагоны'
    puts '5 - seed'
    puts '0 или stop - выход'
  end
end
