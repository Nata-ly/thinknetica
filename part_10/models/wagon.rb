# frozen_string_literal: true

require_relative './lib/manufactured_company'
require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validate'
require_relative './lib/validation'

# Class with common wagons methods.
class Wagon
  include ManufacturedCompany
  include InstanceCounter
  extend AllInstances
  include Validation

  attr_reader :type, :number

  validate :number, :presence

  def initialize(number, type = :unknown)
    @type = type
    @number = number
    validate!
    register_instance
    self.class.add_instaces(self)
  end

  def to_s
    "#{@number} - #{@type}: свободно #{@free_places}, занято #{@busy}"
  end
end
