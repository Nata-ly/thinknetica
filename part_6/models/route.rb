# frozen_string_literal: true

require_relative './lib/instance_counter'

class Route
  attr_reader :route_list, :train_list
  include InstanceCounter

  def initialize(first_station, last_stashion)
    @route_list = [first_station, last_stashion]
    @train_list = []
    register_instance
  end

  def add_station(station)
    @route_list.insert(@route_list.size - 2, station)
    @train_list.each { |train| train.station_index += 1 unless train.station_index == train_list.size - 1 }
  end

  # В задании нет информации должны ли станции быть уникальны в маршруте,
  # поэтому исключаются первая и последняя станция в блоке итерации
  def delete_station(station)
    index_in_route = (1...  @route_list.size - 1).find_all { |i|   @route_list[i] == station }.reverse
    @route_list.delete_if.with_index { |x, i| x == station && ![0, @route_list.size - 1].include?(i) }
    @train_list.each { |train| index_in_route.size.times { |i| train.station_index -= 1 if train.station_index >= index_in_route[i] }}
  end

  def print_route_list
    @route_list.each { |route| puts route.name }
  end

  def add_train_list(train)
    @train_list << train
  end

end
