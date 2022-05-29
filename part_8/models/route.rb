# frozen_string_literal: true

require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validate'

class Route
  attr_reader :station_list, :train_list
  include InstanceCounter
  extend AllInstances
  include Validate

  def initialize(first_station = nil, last_stashion = nil)
    @station_list = [first_station, last_stashion]
    @train_list = []
    validate!
    register_instance
    self.class.add_instaces(self)
  end

  def add_station(station)
    @station_list.insert(@station_list.size - 2, station)
    @train_list.each { |train| train.station_index += 1 unless train.station_index == train_list.size - 1 }
  end

  # В задании нет информации должны ли станции быть уникальны в маршруте,
  # поэтому исключаются первая и последняя станция в блоке итерации
  def delete_station(station)
    index_in_route = (1...  @station_list.size - 1).find_all { |i|   @station_list[i] == station }.reverse
    @station_list.delete_if.with_index { |x, i| x == station && ![0, @station_list.size - 1].include?(i) }
    @train_list.each { |train| index_in_route.size.times { |i| train.station_index -= 1 if train.station_index >= index_in_route[i] }}
  end

  def add_train_list(train)
    @train_list << train
  end

  def print_station_list
    @station_list.each(&:name)
  end

  private

  def validate!
    raise 'Не задана первая станция' if @station_list[0].nil?
    raise 'Не задана последняя станция' if @station_list[@station_list.size - 1].nil?
  end

end
