# frozen_string_literal: true

require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validation'
require_relative './station'

# Class containing methods for creating and working with routes.
class Route
  include InstanceCounter
  extend AllInstances
  include Validation

  attr_reader :station_list, :train_list

  validate :first_station, :type, Station
  validate :last_stashion, :type, Station

  def initialize(first_station = nil, last_stashion = nil)
    @first_station = first_station
    @last_stashion = last_stashion
    @station_list = [@first_station, @last_stashion]
    @train_list = []
    validate!
    register_instance
    self.class.add_instaces(self)
  end

  def add_station(station)
    @station_list.insert(@station_list.size - 2, station)
    @train_list.each { |train| train.station_index += 1 unless train.station_index == train_list.size - 1 }
  end

  def delete_station(station)
    index_in_route = find_index_in_route
    @station_list.delete_if.with_index { |x, i| x == station && ![0, @station_list.size - 1].include?(i) }
    @train_list.each do |train|
      index_in_route.size.times { |i| train.station_index -= 1 if train.station_index >= index_in_route[i] }
    end
  end

  def find_index_in_route
    (1...@station_list.size - 1).find_all { |i| @station_list[i] == station }.reverse
  end

  def add_train_list(train)
    @train_list << train
  end

  def print_station_list
    @station_list.each(&:name)
  end
end
