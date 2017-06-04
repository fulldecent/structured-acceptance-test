module StatModule
  require_relative 'JSONable'

  class Finding < JSONable

    ##
    # Initialize new Finding object
    #
    # Params:
    # +failure+:: boolean, required
    # +rule+:: String, required
    # +description+:: String, required
    # +hash+:: Hash, can be null
    def initialize(failure, rule, description, hash = nil)
      if hash.is_a? Hash
        super(hash)
        return
      end

      raise TypeException unless rule.is_a?(String) && description.is_a?(String)
      @failure = failure
      @rule = rule
      @description = description
    end

    ##
    # Set failure
    #
    # Params:
    # +failure+:: boolean
    def failure=(failure)
      @failure = failure
    end

    ##
    # Get failure
    def failure
      @failure
    end

    ##
    # Set rule
    #
    # Params:
    # +rule+:: String
    def rule=(rule)
      raise TypeException unless rule.is_a?(String)
      @rule = rule
    end

    ##
    # Get rule
    def rule
      @rule
    end

    ##
    # Set description
    #
    # Params:
    # +description+:: String
    def description=(description)
      raise TypeException unless description.is_a?(String)
      @description = description
    end

    ##
    # Get description
    def description
      @description
    end

    ##
    # Set detail
    #
    # Params:
    # +detail+:: StatModule::Detail
    def detail=(detail)
      raise TypeException unless detail.is_a?(StatModule::Detail)
      @detail = detail
    end

    def detail
      @detail
    end

    ##
    # Set array of categories
    #
    # Params:
    # +categories+:: array of StatModule::Category
    def categories=(categories)
      raise TypeException unless categories.is_a?(Array)
      categories.each { |item|
        raise TypeException unless Category.all.include?(item)
        raise DuplicateElementException if @categories.include?(item)
        @categories.push(item)
      }
    end

    ##
    # Get array of StatModule::Category objects
    def categories
      @categories
    end

    ##
    # Set location
    #
    # Params:
    # +location+:: StatModule::Location
    def location=(location)
      raise TypeException unless location.is_a?(Location)
      @location = location
    end

    ##
    # Get location
    def location
      @location
    end

    ##
    # Set time to fix
    #
    # Params:
    # +time_to_fix+:: Integer
    def time_to_fix=(time_to_fix)
      raise TypeException unless time_to_fix.is_a?(Integer)
      @timeToFix = time_to_fix
    end

    ##
    # Get time to fix
    def time_to_fix
      @timeToFix
    end

    ##
    # Set recommendation
    #
    # Params:
    # +recommendation+:: String
    def recommendation=(recommendation)
      raise TypeException unless recommendation.is_a?(String)
      @recommendation = recommendation
    end

    ##
    # Get recommendation
    def recommendation
      @recommendation
    end

    ##
    # Set fixes
    #
    # Params:
    # +fixes+:: array of StatModule::Fix
    def fixes=(fixes)
      raise TypeException unless fixes.is_a?(Array)
      fixes.each { |item|
        raise TypeException unless item.is_a?(StatModule::Fix)
        raise DuplicateElementException if @fixes.include?(item)
        @fixes.push(item)
      }
    end

    ##
    # Get array of StatModule::Fix objects
    def fixes
      @fixes
    end

    ##
    # Get formatted information about findings
    #
    # Params:
    #
    # +formatted+:: indicate weather print boring or pretty colorful finding
    def print(formatted = false)
      result = "#{rule}, #{description}"
      if formatted
        if failure
          result = "#{FORMATTING_BALL} #{result}".colorize(:red)
        else
          result = "#{FORMATTING_WARNING} #{result}".colorize(:yellow)
        end
      end
      result += "\n#{location.print}" unless location.nil?
      result += "\nRECOMMENDATION: #{recommendation}" unless recommendation.nil?
      result
    end
  end
end