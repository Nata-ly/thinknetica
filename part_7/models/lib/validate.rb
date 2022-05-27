#frozen_string_literal: true

module Validate
  def validate?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Логика для метода validate! класса #{self.class} не реализована"
  end
end
