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

    ##
    # Initialize new Stat object
    #
    # Params:
    # +process+:: StatModule::Process, required
    # +hash+:: Hash, can be null
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

    ##
    # Set array of findings
    #
    # Params:
    # +findings+:: Array of StatModule::Finding
    def findings=(findings)
      raise TypeException unless findings.is_a?(Array)
      findings.each { |item|
        raise TypeException unless item.is_a?(StatModule::Finding)
        raise DuplicateElementException if @findings.include?(item)
        @findings.push(item)
      }
    end

    ##
    # Get array of findings
    def findings
      @findings
    end

    ##
    # Set process
    #
    # Params:
    # +process+:: instance of StatModule::Process
    def process=(process)
      raise TypeException unless process.is_a?(StatModule::Process)
      @process = process
    end

    ##
    # Get process
    def process
      @process
    end

    ##
    # Prints header of STAT object in json format
    # Header contains statVersion, process and optional array of findings
    def print_header
      @finding_print_index = 0
      hash = {}
      hash['statVersion'] = @statVersion
      hash['process'] = @process
      hash['findings'] = []
      result = hash.to_json
      result = result[0..result.length - 3]
      puts(result)
      puts
      $stdout.flush
    end

    ##
    # Prints one finding in json format.
    def print_finding
      if @finding_print_index < @findings.length
        result = @findings[@finding_print_index].to_json
        result += ',' unless @finding_print_index >= @findings.length - 1
        puts result
        puts
        $stdout.flush
        @finding_print_index += 1
      else
        raise IndexOutOfBoundException
      end
    end

    ##
    # Prints footer of STAT object in json format
    def print_footer
      @finding_print_index = 0
      puts ']}'
      puts
      $stdout.flush
    end

    ##
    # Get STAT object in json format
    def to_json(options = {})
      super(['finding_print_index'])
    end

    ##
    # Get statistic information about findings
    #
    # Params:
    #
    # +formatted+:: indicate weather print boring or pretty colorful statistic
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