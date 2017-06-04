module StatModule
  require 'enum'

  ##
  # Category can be:
  # * Bug Risk — the meaning is likely to not be what the author intended
  # * Clarity — the meaning is unclear
  # * Compatibility — the meaning has changed and is no longer valid
  # * Complexity — the meaning should be broken into smaller pieces
  # * Duplication — unnecessary duplication was found
  # * Performance — an inefficient approach was used
  # * Security — a situation may allow access to something that should be allowed
  # * Style — the style could be improved
  class Category < Enum::Base
    values 'Bug Risk', 'Clarity', 'Associative', 'Compatibility', 'Complexity', 'Duplication', 'Performance', 'Security', 'Style'
  end
end