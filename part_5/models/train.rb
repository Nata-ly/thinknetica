# frozen_string_literal: true

class Train
  attr_reader :number, :type, :speed, :list_wagons, :station
  attr_accessor :station_index
  @@train_list = []

  TRAIN_TYPE = %i[cargo passenger unknown].freeze

  def initialize(number)
    @number = number
    @type = :unknown
    @list_wagons = []
    @speed = 0
    @@train_list << self
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
    @list_wagons << wagons
    'Вагон добавлен'
  end

  def delete_wagons(wagons)
    return 'Сбросьте скорость' unless @speed.zero?
    @list_wagons.delete(wagons)
    'Вагон удален'
  end

  def add_route(route)
    @station.move_train(self) unless @station.nil?
    @route = route
    @station = route.route_list[0]
    @station_index = 0 # Добавлена на случай не уникальности станций в маршруте
    @station.train_arrival(self)
    @route.add_train_list(self)
  end

  def move_next_station
    if @route && last_station?
      puts 'Последняя станция, движение вперед невозможно'
    elsif @route
      update_sration(1)
      puts "Поезд едит вперед, текущая станция - #{station.name}"
    else
      puts 'Не задан маршрут'
    end
  end

  def move_past_station
    if @route && first_station?
      puts 'Первая станция, движение назад невозможно'
    elsif @route
      update_sration(-1)
      puts "Поезд едит назад, текущая станция - #{station.name}"
    else
      puts 'Не задан маршрут'
    end
  end

  def past_station
    first_station? ? nil : @route.route_list[@station_index - 1]
  end

  def next_station
    last_station? ? nil : @route.route_list[@station_index - 1]
  end

  def self.train_list
    @@train_list
  end

  protected

  def last_station?
    @station_index == @route.route_list.size - 1
  end

  def first_station?
    @station_index.zero?
  end

  def update_sration(number)
    @station.move_train(self)
    @station_index += number
    @station = @route.route_list[@station_index]
    @station.train_arrival(self)
  end
end
