# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(number)
    super
    @type = :cargo
  end
end
