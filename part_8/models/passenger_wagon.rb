# frozen_string_literal: true

require_relative './lib/wagon_occupancy.rb'

class PassengerWagon < Wagon
  include WagonOccupancy

  def initialize(number, capacity)
    @capacity = capacity
    @busy = 0
    super(number, :passenger)
  end

  def take_place_of
    super(1)
  end
end
