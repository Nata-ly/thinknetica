# frozen_string_literal: true

# Vallidate methods
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethod
  end

  module ClassMethods
    attr_reader :validate_list

    def validate(name, type, attr = nil)
      value = { name: name, type: type, attr: attr }
      instance_variable_set(:@validate_list, (@validate_list || []).push(value))
    end

    def inherited(subclass)
      subclass.instance_variable_set(:@validate_list, @validate_list)
      super
    end
  end

  module InstanceMethod
    def validate!
      self.class.validate_list.each { |validate| validation_check(validate) }
    end

    def validation_check(args)
      name = instance_variable_get("@#{args[:name]}".to_sym)
      raise "#{args[:name]} не может быть равен нулю" if args[:type] == :presence && (name.nil? || name == '')
      raise "#{args[:name]} не соответствует формату" if args[:type] == :format && name !~ args[:attr]
      raise "#{args[:name]} не соответствует классу"  if args[:type] == :type && !name.instance_of?(args[:attr])

      true
    end

    def validate?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
