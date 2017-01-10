require 'enum'

class StatCategory < Enum::Base
  values 'Bug Risk', 'Clarity', 'Associative', 'Compatibility', 'Complexity', 'Duplication', 'Performance', 'Security', 'Style'
end