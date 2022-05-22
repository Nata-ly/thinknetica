# frozen_string_literal: true

class Train
  attr_reader :number, :type, :speed, :amount_wagons, :station

  TRAIN_TYPE = %i[cargo passenger].freeze

  def initialize(number, type, amount_wagons = 0)
    @number = number
    @type = type
    @amount_wagons = amount_wagons
    @speed = 0

    raise 'Ошибка в данных, поезд не может быть создан' unless TRAIN_TYPE.include?(@type)
  end

  def add_speed(speed)
    @speed += speed
  end

  def brake
    @speed = 0
  end

  def add_wagons
    @amount_wagons += 1 if @speed.zero?
  end

  def delete_wagons
    @amount_wagons -= 1 if @speed.zero?
  end

  def add_route(route)
    @station.move_train(self) unless @station.nil?
    @route = route
    @station = route.route_list[0]
    @station_index = 0 # Добавлена на случай не уникальности станций в маршруте
    @station.train_arrival(self)
  end

  def move_next_station
    if last_station?
      puts 'Последняя станция, движение вперед невозможно'
    else
      update_sration(1)
    end
  end

  def move_past_station
    if first_station?
      puts 'Первая станция, движение назад невозможно'
    else
      update_sration(-1)
    end
  end

  def past_station
    first_station? ? nil : @route.route_list[@station_index - 1]
  end

  def next_station
    last_station? ? nil : @route.route_list[@station_index - 1]
  end

  private

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
