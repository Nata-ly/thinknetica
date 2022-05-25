# frozen_string_literal: true

require_relative './lib/manufactured_company'
require_relative './lib/instance_counter'

class Wagon
  include ManufacturedCompany
  include InstanceCounter

  attr_reader :type, :number

  def initialize(number)
    @type = :unknown
    @number = number
    register_instance
  end

end
