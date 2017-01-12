module StatModule
  require 'enum'

  class Category < Enum::Base
    values 'Bug Risk', 'Clarity', 'Associative', 'Compatibility', 'Complexity', 'Duplication', 'Performance', 'Security', 'Style'
  end
end