# frozen_string_literal: true

# Extends wagon classes with methods.
module WagonOccupancy
  attr_reader :capacity, :busy

  def take_place_of(quantity)
    raise 'Не хватает места' if quantity > free_places

    self.busy += quantity
  end

  def free_places
    capacity - self.busy
  end

  private

  attr_writer :capacity, :busy
end
