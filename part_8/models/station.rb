# frozen_string_literal: true

require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validate'

class Station
  include InstanceCounter
  extend AllInstances
  include Validate

  attr_reader :name, :train_list

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

  def each_trains_list
    train_list.each { |train| yield(train) } if block_given?
  end

  private

  def validate!
    raise 'Название не может быть пустым' if @name.nil? || @name.length.zero?
    raise 'Название в недопустимом формате' if @name.length < 3
  end
end
