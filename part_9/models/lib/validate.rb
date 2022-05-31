# frozen_string_literal: true

# Adds validation methods.
module Validate
  def validate?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise "Логика для метода validate! класса #{self.class} не реализована"
  end
end
