# frozen_string_literal: true

require_relative './lib/manufactured_company'
require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validate'

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

  protected

  def validate!
    raise 'Номер должен быть строкой' unless @number.class == String
    raise 'Номер не может быть пустым' if @number.length.zero?
    raise 'Номер в недопустимом формате' if @number.length < 3
  end
end
