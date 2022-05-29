#frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethod
  end

  module ClassMethods
    attr_reader :instances

    protected

    attr_writer :instances
  end

  module InstanceMethod
    protected

    def register_instance
      self.class.class_eval do
        self.instances = (self.instances.nil? ? 1 : self.instances + 1)
      end
    end
  end
end
