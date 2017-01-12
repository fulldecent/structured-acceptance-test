module StatModule
  require_relative 'JSONable'

  class Detail < JSONable

    def initialize(body)
      @body = body
      @trace = []
    end

    def body=(body)
      raise TypeException unless body.is_a?(String)
      @body = body
    end

    def body
      @body
    end

    def trace=(trace)
      raise TypeException unless trace.is_a?(Array)
      trace.each { |item|
        raise TypeException unless item.is_a?(StatModule::Location)
        raise DuplicateElementException if @trace.include?(item)
        @trace.push(item)
      }
    end

    def trace
      @trace
    end
  end
end