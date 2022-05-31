# frozen_string_literal: true

require_relative './lib/manufactured_company'
require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validate'

# Class with common train methods.
class Train
  include ManufacturedCompany
  include InstanceCounter
  extend AllInstances
  include Validate

  TRAIN_NUMBER_FORMAT = /^([a-zа-я]|\d){3}-*([a-zа-я]|\d){2}/i.freeze

  attr_reader :number, :type, :speed, :list_wagons, :station
  attr_accessor :station_index

  def initialize(number = nil)
    @number = number
    @type = :unknown
    @list_wagons = []
    @speed = 0
    validate!
    register_instance
    self.class.add_instaces(self)
  end

  def add_speed(speed)
    @speed += speed
  end

  def brake
    @speed = 0
  end

  def add_wagons(wagons)
    return 'Не подходящий тип вагона' unless wagons.type == @type
    return 'Сбросьте скорость' unless @speed.zero?
    return 'Вагон уже был добавлен' if @list_wagons.include?(wagons)

    @list_wagons << wagons
    'Вагон добавлен'
  end

  def delete_wagons(wagons)
    return 'Сбросьте скорость' unless @speed.zero?

    @list_wagons.delete(wagons)
    'Вагон удален'
  end

  def add_route(route)
    @station&.move_train(self)
    @route = route
    @station = route.station_list[0]
    @station_index = 0
    @station.train_arrival(self)
    @route.add_train_list(self)
  end

  def move_next_station
    if @route && last_station?
      'Последняя станция, движение вперед невозможно'
    elsif @route
      update_sration(1)
      "Поезд едит вперед, текущая станция - #{station.name}"
    else
      'Не задан маршрут'
    end
  end

  def move_past_station
    if @route && first_station?
      'Первая станция, движение назад невозможно'
    elsif @route
      update_sration(-1)
      "Поезд едит назад, текущая станция - #{station.name}"
    else
      'Не задан маршрут'
    end
  end

  def past_station
    first_station? ? nil : @route.station_list[@station_index - 1]
  end

  def next_station
    last_station? ? nil : @route.station_list[@station_index - 1]
  end

  def self.find(number)
    all.find { |train| train.number == number }
  end

  def each_wagons_list(&block)
    list_wagons.each(&block) if block_given?
  end

  def to_s
    "#{@number}: тип #{@type}, кол-во вагонов #{@list_wagons.size}"
  end

  protected

  def validate!
    raise 'Номер должен быть строкой' unless @number.instance_of?(String)
    raise 'Номер не может быть пустым' if @number.length.zero?
    raise 'Номер поезда в недопустимом формате' if @number !~ TRAIN_NUMBER_FORMAT
  end

  def last_station?
    @station_index == @route.station_list.size - 1
  end

  def first_station?
    @station_index.zero?
  end

  def update_sration(number)
    @station.move_train(self)
    @station_index += number
    @station = @route.station_list[@station_index]
    @station.train_arrival(self)
  end
end
