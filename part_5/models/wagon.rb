# frozen_string_literal: true

class Wagon
  attr_reader :type, :number
  @@wagon_list = []

  def initialize(number)
    @type = :unknown
    @number = number
    @@wagon_list << self
  end

  def self.wagon_list
    @@wagon_list
  end
end
