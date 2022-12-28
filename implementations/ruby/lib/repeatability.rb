module StatModule
  require 'enum'

  ##
  # Repeatability can be:
  # * Volatile — findings MAY change when repeating validation on the identical targets
  # * Repeatable — Findings MUST be identical if the program is run again with the same inputs
  # * Associative — Findings for targets [a, b] MUST equal the union of findings for [a] and [b] -- in other words, if only one file is changed, only that file need be tested
  class Repeatability < Enum::Base
    values 'Volatile', 'Repeatable', 'Associative'
  end
end