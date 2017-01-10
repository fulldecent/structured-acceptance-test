require 'enum'

class StatCategory < Enum::Base
  values :bug_risk, :clarity, :associative, :compatibility, :complexity, :duplication, :performance, :security, :style
end