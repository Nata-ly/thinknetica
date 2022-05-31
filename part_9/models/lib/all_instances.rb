# frozen_string_literal: true

# Add tclass instances to array
module AllInstances
  def all
    all_instances.nil? ? [] : all_instances
  end

  def add_instaces(instance)
    self.all_instances = [] if all_instances.nil?
    all_instances.push(instance)
  end

  protected

  attr_accessor :all_instances
end
