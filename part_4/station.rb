# frozen_string_literal: true

class Station
  attr_reader :name, :train_list

  def initialize(name)
    @name = name
    @train_list = []
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
end
