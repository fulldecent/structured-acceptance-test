require_relative 'JSONable'

class Fix < JSONable
  @location
  @newText

  def initialize(location)
    @location = location
  end

  def location=(location)
    throw :typeError unless location.is_a?(Location)
    @location = location
  end

  def location
    @location
  end

  def new_text=(new_text)
    throw :typeError unless new_text.is_a?(String)
    @newText = new_text
  end

  def new_text
    @newText
  end
end