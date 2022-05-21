# frozen_string_literal: true

class Route
  attr_reader :route_list

  def initialize(first_station, last_stashion)
    @route_list = [first_station, last_stashion]
  end

  def add_station(station)
    @route_list.insert(@route_list.size - 2, station)
  end

  # В задании нет информации должны ли станции быть уникальны,
  # поэтому исключаются первая и последняя станция в блоке итерации
  def delete_station(station)
    @route_list.delete_if.with_index { |x, i| x == station && ![0, @route_list.size - 1].include?(i) }
  end

  def print_route_list
    route_list.each { |route| puts route.name }
  end
end
