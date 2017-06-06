module StatModule
  require_relative 'JSONable'

  class Fix < JSONable

    ##
    # Initialize new Fix object
    #
    # Params:
    # +location+:: StatModule::Location, required
    # +hash+:: Hash, can be null
    def initialize(location, hash = nil)
      if hash.is_a? Hash
        super(hash)
        return
      end
      @location = location
    end

    ##
    # Set location
    #
    # Params:
    # +location+:: StatModule::Location
    def location=(location)
      raise TypeException unless location.is_a?(StatModule::Location)
      @location = location
    end

    ##
    # Get location
    def location
      @location
    end

    ##
    # Set new text
    #
    # Params:
    # +new_text+:: String
    def new_text=(new_text)
      raise TypeException unless new_text.is_a?(String)
      @newText = new_text
    end

    ##
    # Get new text
    def new_text
      @newText
    end
  end
end