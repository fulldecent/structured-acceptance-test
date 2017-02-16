module StatModule

  require_relative 'JSONable'

  class Process < JSONable

    def initialize(name, hash = nil)
      if hash.is_a? Hash
        super(hash)
        return
      end

      raise TypeException unless name.is_a?(String)
      @name = name
    end

    def name=(name)
      raise TypeException unless name.is_a?(String)
      @name = name
    end

    def name
      @name
    end

    def version=(version)
      raise TypeException unless version.is_a?(String)
      @version = version
    end

    def version
      @version
    end

    def description=(description)
      raise TypeException unless description.is_a?(String)
      @description = description
    end

    def description
      @description
    end

    def maintainer=(maintainer)
      raise TypeException unless maintainer.is_a?(String)
      @maintainer = maintainer
    end

    def maintainer
      @maintainer
    end

    def email=(email)
      raise TypeException unless email.is_a?(String)
      @email = email
    end

    def email
      @email
    end

    def website=(website)
      raise TypeException unless website.is_a?(String)
      @website = website
    end

    def website
      @website
    end

    def repeatability=(repeatability)
      raise TypeException unless Repeatability.all.include?(repeatability)
      @repeatability = repeatability
    end

    def repeatability
      @repeatability
    end

    def print(formatted = nil)
      result = name
      unless version.nil?
        result += ", version #{version}"
      end
      if formatted
        result = "#{FORMATTING_STAR.colorize(:yellow)} #{result}"
      end
      result
    end
  end
end
