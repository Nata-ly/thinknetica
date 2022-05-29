#frozen_string_literal: true

module AllInstances
  def all
    self.all_instances.nil? ? [] : self.all_instances
  end

  def add_instaces(instance)
    self.all_instances = [] if self.all_instances.nil?
    self.all_instances.push(instance)
  end

  protected

  attr_accessor :all_instances
end
