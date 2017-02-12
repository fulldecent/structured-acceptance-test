module StatModule
  require_relative 'JSONable'

  class Finding < JSONable

    def initialize(failure, rule, description, hash = nil)
      @categories = []
      @fixes = []

      if hash.is_a? Hash
        super(hash)
        return
      end

      raise TypeException unless rule.is_a?(String) && description.is_a?(String)
      @failure = failure
      @rule = rule
      @description = description
    end

    def failure=(failure)
      @failure = failure
    end

    def failure
      @failure
    end

    def rule=(rule)
      raise TypeException unless rule.is_a?(String)
      @rule = rule
    end

    def rule
      @rule
    end

    def description=(description)
      raise TypeException unless description.is_a?(String)
      @description = description
    end

    def description
      @description
    end

    def detail=(detail)
      raise TypeException unless detail.is_a?(StatModule::Detail)
      @detail = detail
    end

    def detail
      @detail
    end

    def categories=(categories)
      raise TypeException unless categories.is_a?(Array)
      categories.each { |item|
        raise TypeException unless Category.all.include?(item)
        raise DuplicateElementException if @categories.include?(item)
        @categories.push(item)
      }
    end

    def categories
      @categories
    end

    def location=(location)
      raise TypeException unless location.is_a?(Location)
      @location = location
    end

    def location
      @location
    end

    def time_to_fix=(time_to_fix)
      raise TypeException unless time_to_fix.is_a?(Integer)
      @timeToFix = time_to_fix
    end

    def time_to_fix
      @timeToFix
    end

    def recommendation=(recommendation)
      raise TypeException unless recommendation.is_a?(String)
      @recommendation = recommendation
    end

    def recommendation
      @recommendation
    end

    def fixes=(fixes)
      raise TypeException unless fixes.is_a?(Array)
      @fixes.each { |item|
        raise TypeException unless item.is_a?(StatModule::Fix)
        raise DuplicateElementException if @fixes.include?(item)
        @fixes.push(item)
      }
    end

    def fixes
      @fixes
    end

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