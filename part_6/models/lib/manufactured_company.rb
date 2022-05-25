#frozen_string_literal: true

module ManufacturedCompany
  def manufactured
    self.company_name
  end

  def identify_manufactured(name)
    self.company_name = name
  end

  protected

  attr_accessor :company_name
end
