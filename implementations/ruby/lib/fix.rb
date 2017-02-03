module StatModule
  require_relative 'JSONable'

  class Fix < JSONable

    def initialize(location, hash = nil)
      if hash.is_a? Hash
        super(hash)
        return
      end
      @location = location
    end

    def location=(location)
      raise TypeException unless location.is_a?(StatModule::Location)
      @location = location
    end

    def location
      @location
    end

    def new_text=(new_text)
      raise TypeException unless new_text.is_a?(String)
      @newText = new_text
    end

    def new_text
      @newText
    end
  end
end