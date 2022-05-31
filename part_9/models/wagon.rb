# frozen_string_literal: true

require_relative './lib/manufactured_company'
require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validate'

# Class with common wagons methods.
class Wagon
  include ManufacturedCompany
  include InstanceCounter
  extend AllInstances

  attr_reader :type, :number

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

  protected

  def validate!
    raise 'Номер должен быть строкой' unless @number.instance_of?(String)
    raise 'Номер не может быть пустым' if @number.length.zero?
    raise 'Номер в недопустимом формате' if @number.length < 3
  end
end
