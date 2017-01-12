module StatModule
  require 'json'

  class JSONable
    def to_json(options = {})
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.delete "@"] = self.instance_variable_get var
      end
      hash.to_json
    end
  end
end