require_relative 'JSONable'

class Location < JSONable
  @path
  @beginLine
  @beginColumn
  @endLine
  @endColumn

  def initialize(path)
    @path = path
  end

  def path=(path)
    throw :typeError unless path.is_a?(String)
    @path = path
  end

  def path
    @path
  end

  def begin_line=(begin_line)
    throw :typeError unless begin_line.is_a?(Integer)
    @beginLine = begin_line
  end

  def begin_line
    @beginLine
  end

  def begin_column=(begin_column)
    throw :typeError unless begin_column.is_a?(Integer)
    @beginColumn = begin_column
  end

  def begin_column
    @beginColumn
  end

  def end_line=(end_line)
    throw :typeError unless end_line.is_a?(Integer)
    @endLine = end_line
  end

  def end_line
    @endLine
  end

  def end_column=(end_column)
    throw :typeError unless end_column.is_a?(Integer)
    @endColumn = end_column
  end

  def end_column
    @endColumn
  end
end