require 'enum'

class Repeatability < Enum::Base
  values :volatile, :repeatable, :associative
end