# frozen_string_literal: true

require_relative './models/route'
require_relative './models/station'
require_relative './models/train'
require_relative './models/cargo_train'
require_relative './models/passenger_train'
require_relative './models/wagon'
require_relative './models/passenger_wagon'
require_relative './models/cargo_wagon'
require_relative './text_interface'

TextInterface.new.call
