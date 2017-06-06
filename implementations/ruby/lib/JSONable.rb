module StatModule
  require 'json'
  require 'colorize'

  class JSONable

    FORMATTING_STAR = '⭐'
    FORMATTING_CHECKMARK = '✅'
    FORMATTING_BALL = '⚫'
    FORMATTING_WARNING = '⚠'

    ##
    # Initialize object extending JSONable
    #
    # Params:
    # +hash+:: Hash
    def initialize(hash)
      if hash.is_a? Hash
        hash.each do |k, v|
          if v.is_a? Array
            items = []
            v.each { |i|
              case k
                when 'findings'
                  item = StatModule::Finding.new(nil, nil, nil, i)
                when 'fixes'
                  item = StatModule::Fix.new(nil, i)
                when 'traces'
                  item = StatModule::Location.new(nil, i)
                else
                  v = item
              end
              items.push(item)
            }
            v = items
          end
          if v.is_a? Hash
            case k
              when 'process'
                v = StatModule::Process.new(nil, v)
              when 'location'
                v = StatModule::Location.new(nil, v)
              when 'detail'
                v = StatModule::Detail.new(nil, v)
            end
          end
          self.instance_variable_set("@#{k}", v) ## create and initialize an instance variable for this key/value pair
          self.class.send(:define_method, k, proc { self.instance_variable_get("@#{k}") }) ## create the getter that returns the instance variable
          self.class.send(:define_method, "#{k}=", proc { |v| self.instance_variable_set("@#{k}", v) }) ## create the setter that sets the instance variable
        end
      end
    end

    ##
    # Get object in pretty json format
    #
    # Params:
    # +excluded_fields+:: array of String - attributes to exclude
    def to_json(excluded_fields = [])
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.delete "@"] = self.instance_variable_get var unless excluded_fields.is_a?(Array) && excluded_fields.include?(var.to_s.delete "@")
      end
      JSON.pretty_generate(hash)
    end

    ##
    # Generate Hash from json string
    def self.from_json!(string)
      JSON.load(string).each do |var, val|
        self.instance_variable_set '@' + var, val
      end
    end
  end
end