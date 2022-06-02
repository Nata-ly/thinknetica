# frozen_string_literal: true

require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validation'

# Class with common station methods.
class Station
  include InstanceCounter
  extend AllInstances
  include Validation

  attr_reader :name, :train_list

  validate :name, :presence
  validate :name, :type, String

  def initialize(name)
    @name = name
    @train_list = []
    validate!
    register_instance
    self.class.add_instaces(self)
  end

  def train_arrival(train)
    @train_list << train
  end

  # [{:cargo=>1}, {:passenger=>2}]
  def train_list_by_type
    @train_list.group_by(&:type).map { |k, v| { k => v.size } }
  end

  def count_train_list
    @train_list.size
  end

  def move_train(train)
    @train_list.delete(train)
  end

  def each_trains_list(&block)
    train_list.each(&block) if block_given?
  end
end
