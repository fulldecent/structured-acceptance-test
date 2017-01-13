module StatModule
  require 'json'

  class JSONable
    def to_json(excluded_fields = [])
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.delete "@"] = self.instance_variable_get var unless excluded_fields.is_a?(Array) && excluded_fields.include?(var.to_s.delete "@")
      end
      hash.to_json
    end
  end
end