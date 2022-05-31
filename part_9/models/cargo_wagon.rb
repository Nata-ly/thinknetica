# frozen_string_literal: true

require_relative './lib/wagon_occupancy'

# CargoWagon
class CargoWagon < Wagon
  include WagonOccupancy

  def initialize(number, capacity)
    @capacity = capacity
    @busy = 0
    super(number, :cargo)
  end
end
