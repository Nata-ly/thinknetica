#frozen_string_literal: true

module WagonOccupancy
  attr_reader :capacity, :busy

  def take_place_of(quantity)
    raise 'Не хватает места' if quantity > self.free_places
    self.busy += quantity
  end

  def free_places
    self.capacity - self.busy
  end

  private

  attr_writer :capacity, :busy

end
