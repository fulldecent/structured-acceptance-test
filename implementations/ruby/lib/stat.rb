module StatModule

  require_relative 'detail'
  require_relative 'finding'
  require_relative 'fix'
  require_relative 'location'
  require_relative 'process'
  require_relative 'repeatability'
  require_relative 'category'
  require_relative 'JSONable'
  require_relative 'type_exception'

  class Stat < JSONable
    attr_reader :statVersion

    def initialize(process)
      raise TypeException unless process.is_a?(StatModule::Process)
      @statVersion = '1.0.0'
      @process = process
      @findings = []
    end

    def findings=(findings)
      raise TypeException unless findings.is_a?(Array)
      findings.each { |item|
        raise TypeException unless item.is_a?(StatModule::Finding)
        raise DuplicateElementException if @findings.include?(item)
        @findings.push(item)
      }
    end

    def findings
      @findings
    end

    def process=(process)
      raise TypeException unless process.is_a?(StatModule::Process)
      @process = process
    end

    def process
      @process
    end
  end
end