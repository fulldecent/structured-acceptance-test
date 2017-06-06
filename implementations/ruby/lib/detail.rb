module StatModule
  require_relative 'JSONable'

  class Detail < JSONable

    ##
    # Initialize new Detail object
    #
    # Params:
    # +body+:: String, required
    # +hash+:: Hash, can be null
    def initialize(body, hash = nil)
      if hash.is_a? Hash
        super(hash)
        return
      end

      raise TypeException unless body.is_a?(String)
      @body = body
    end

    ##
    # Set body
    #
    # Params:
    # +body+:: String
    def body=(body)
      raise TypeException unless body.is_a?(String)
      @body = body
    end

    ##
    # Get body
    def body
      @body
    end

    ##
    # Set trace
    #
    # Params:
    # +trace+:: array of StatModule::Location objects
    def trace=(trace)
      raise TypeException unless trace.is_a?(Array)
      trace.each { |item|
        raise TypeException unless item.is_a?(StatModule::Location)
        raise DuplicateElementException if @trace.include?(item)
        @trace.push(item)
      }
    end

    ##
    # Get trace
    def trace
      @trace
    end
  end
end