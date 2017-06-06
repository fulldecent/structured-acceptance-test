module StatModule
  require_relative 'JSONable'

  class Location < JSONable

    ##
    # Initialize new Location object
    #
    # Params:
    # +process+:: String, required
    # +hash+:: Hash, can be null
    def initialize(path, hash = nil)
      if hash.is_a? Hash
        super(hash)
        return
      end
      raise TypeException unless path.is_a?(String)
      @path = path
    end

    ##
    # Set path
    #
    # Params:
    # +path+:: String
    def path=(path)
      raise TypeException unless path.is_a?(String)
      @path = path
    end

    ##
    # Get path
    def path
      @path
    end

    ##
    # Set begin line
    #
    # Params:
    # +begin_line+:: Integer
    def begin_line=(begin_line)
      raise TypeException unless begin_line.is_a?(Integer)
      @beginLine = begin_line
    end

    ##
    # Get begin line number
    def begin_line
      @beginLine
    end

    ##
    # Set begin column
    #
    # Params:
    # +begin_column+:: Integer
    def begin_column=(begin_column)
      raise TypeException unless begin_column.is_a?(Integer)
      @beginColumn = begin_column
    end

    ##
    # Get begin column number
    def begin_column
      @beginColumn
    end

    ##
    # Set end line
    #
    # Params:
    # +end_line+:: Integer
    def end_line=(end_line)
      raise TypeException unless end_line.is_a?(Integer)
      @endLine = end_line
    end

    ##
    # Get end line number
    def end_line
      @endLine
    end

    ##
    # Set end column
    #
    # Params:
    # +end_column+:: Integer
    def end_column=(end_column)
      raise TypeException unless end_column.is_a?(Integer)
      @endColumn = end_column
    end

    ##
    # Get end column number
    def end_column
      @endColumn
    end

    ##
    # Get formatted information about location
    def print
      result = "in #{path}"
      if !begin_line.nil? && !end_line.nil?
        if begin_line != end_line
          if !begin_column.nil? && !end_column.nil?
            result += ", line #{begin_line}:#{begin_column} to line #{end_line}:#{end_column}"
          elsif !begin_column.nil? && end_column.nil?
            result += ", line #{begin_line}:#{begin_column} to line #{end_line}"
          elsif begin_column.nil? && !end_column.nil?
            result += ", line #{begin_line} to line #{end_line}:#{end_column}"
          else
            result += ", lines #{begin_line}-#{end_line}"
          end
        else
          if begin_column.nil?
            result += ", line #{begin_line}"
          else
            result += ", line #{begin_line}:#{begin_column}"
            result += "-#{end_column}" unless end_column.nil?
          end
        end
      end
      result
    end
  end
end