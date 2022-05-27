# frozen_string_literal: true

require_relative './lib/manufactured_company'
require_relative './lib/instance_counter'
require_relative './lib/all_instances'
require_relative './lib/validate'

class Wagon
  include ManufacturedCompany
  include InstanceCounter

  attr_reader :type, :number

  def initialize(number)
    @type = :unknown
    @number = number
    validate!
    register_instance
  end

  protected

  def validate!
    raise 'Номер не может быть пустым' if @number.nil? || @number.length.zero?
    raise 'Номер в недопустимом формате' if @number.length < 3
  end
end
