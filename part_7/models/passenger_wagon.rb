# frozen_string_literal: true

class PassegerWagon < Wagon
  def initialize(number)
    super
    @type = :passenger
  end
end
