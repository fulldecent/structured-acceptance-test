module StatModule
  require_relative 'JSONable'

  class Location < JSONable

    def initialize(path, hash = nil)
      if hash.is_a? Hash
        super(hash)
        return
      end
      @path = path
    end

    def path=(path)
      raise TypeException unless path.is_a?(String)
      @path = path
    end

    def path
      @path
    end

    def begin_line=(begin_line)
      raise TypeException unless begin_line.is_a?(Integer)
      @beginLine = begin_line
    end

    def begin_line
      @beginLine
    end

    def begin_column=(begin_column)
      raise TypeException unless begin_column.is_a?(Integer)
      @beginColumn = begin_column
    end

    def begin_column
      @beginColumn
    end

    def end_line=(end_line)
      raise TypeException unless end_line.is_a?(Integer)
      @endLine = end_line
    end

    def end_line
      @endLine
    end

    def end_column=(end_column)
      raise TypeException unless end_column.is_a?(Integer)
      @endColumn = end_column
    end

    def end_column
      @endColumn
    end
  end
end