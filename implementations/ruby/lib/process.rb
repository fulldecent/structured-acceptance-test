module StatModule

  require_relative 'JSONable'

  class Process < JSONable

    ##
    # Initialize new Process object
    #
    # Params:
    # +name+:: String, name of the process, required
    # +hash+:: Hash, can be null
    def initialize(name, hash = nil)
      if hash.is_a? Hash
        super(hash)
        return
      end

      raise TypeException unless name.is_a?(String)
      @name = name
    end

    ##
    # Set name of the process
    #
    # Params:
    # +name+:: String, name of the process, required
    def name=(name)
      raise TypeException unless name.is_a?(String)
      @name = name
    end

    ##
    # Get name of the process
    def name
      @name
    end

    ##
    # Set version
    #
    # Params:
    # +version+:: String
    def version=(version)
      raise TypeException unless version.is_a?(String)
      @version = version
    end

    ##
    # Get version of the process
    def version
      @version
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
    # Set maintainer
    #
    # Params:
    # +maintainer+:: String
    def maintainer=(maintainer)
      raise TypeException unless maintainer.is_a?(String)
      @maintainer = maintainer
    end

    ##
    # Get maintainer
    def maintainer
      @maintainer
    end

    ##
    # Set email
    #
    # Params:
    # +email+:: String
    def email=(email)
      raise TypeException unless email.is_a?(String)
      @email = email
    end

    ##
    # Get email
    def email
      @email
    end

    ##
    # Set website
    #
    # Params:
    # +website+:: String
    def website=(website)
      raise TypeException unless website.is_a?(String)
      @website = website
    end

    ##
    # Get website
    def website
      @website
    end

    ##
    # Set repeatability
    #
    # Params:
    # +repeatability+:: String
    def repeatability=(repeatability)
      raise TypeException unless Repeatability.all.include?(repeatability)
      @repeatability = repeatability
    end

    ##
    # Get repeatability
    def repeatability
      @repeatability
    end

    ##
    # Get formatted information about process
    #
    # Params:
    #
    # +formatted+:: indicate weather print boring or pretty colorful process
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
