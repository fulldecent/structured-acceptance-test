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
  require_relative 'duplicate_element_exception'
  require_relative 'index_out_of_bound_exception'

  class Stat < JSONable
    attr_reader :statVersion

    def initialize(process)
      raise TypeException unless process.is_a?(StatModule::Process)
      @statVersion = '1.0.0'
      @process = process
      @findings = []
      @finding_print_index = 0
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

    def print_header
      @finding_print_index = 0
      hash = {}
      hash['statVersion'] = @statVersion
      hash['process'] = @process.to_json
      hash['findings'] = []
      result = hash.to_json.to_s
      result = result[0..result.length - 3]
      puts(result)
      puts
      $stdout.flush
    end

    def print_finding
      if @finding_print_index < @findings.length
        result = @findings[@finding_print_index].to_json
        result += ',' unless @finding_print_index >= @findings.length - 1
        puts(result)
        puts
        $stdout.flush
        @finding_print_index += 1
      else
        raise IndexOutOfBoundException
      end
    end

    def print_footer
      @finding_print_index = 0
      puts ']}'
      puts
      $stdout.flush
    end

    def to_json(options = {})
      super(['finding_print_index'])
    end
  end
end