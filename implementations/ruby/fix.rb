class Fix
  @location
  @new_text

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
    @new_text = new_text
  end

  def new_text
    @new_text
  end
end