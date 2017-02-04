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

    def initialize(process, hash = nil)
      @finding_print_index = 0
      @findings = []

      if hash.is_a? Hash
        super(hash)
        return
      end

      raise TypeException unless process.is_a?(StatModule::Process)
      @statVersion = '1.0.0'
      @process = process
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
    end

    def print_finding
      if @finding_print_index < @findings.length
        result = @findings[@finding_print_index].to_json
        result += ',' unless @finding_print_index >= @findings.length - 1
        puts(result)
        puts
        @finding_print_index += 1
      else
        raise IndexOutOfBoundException
      end
    end

    def print_footer
      @finding_print_index = 0
      puts ']}'
      puts
    end

    def to_json(options = {})
      super(['finding_print_index'])
    end

    def summary_print(formatted = false)
      errors = 0
      warnings = 0
      findings.each { |finding|
        if finding.failure
          errors += 1
        else
          warnings += 1
        end
      }
      if errors == 0 && warnings == 0
        result = "#{FORMATTING_CHECKMARK} PASSED with no warning".colorize(:green)
      elsif errors == 0
        result = "#{FORMATTING_WARNING} PASSED with #{warnings} warning".colorize(:yellow)
      elsif warnings == 0
        result = "#{FORMATTING_BALL} FAILED with #{errors} error".colorize(:red)
      else
        result = "#{FORMATTING_BALL} FAILED with #{errors} error and #{warnings} warning".colorize(:red)
      end
      if formatted
        result
      else
        result[result.index(' ') + 1..result.length]
      end
    end
  end
end