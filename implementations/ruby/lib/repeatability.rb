module StatModule
  require 'enum'

  class Repeatability < Enum::Base
    values 'Volatile', 'Repeatable', 'Associative'
  end
end