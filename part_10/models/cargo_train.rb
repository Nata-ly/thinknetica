# frozen_string_literal: true

# CargoTrain
class CargoTrain < Train
  def initialize(number)
    super
    @type = :cargo
  end
end
