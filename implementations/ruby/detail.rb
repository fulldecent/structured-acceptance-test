class Detail
  @body
  @trace

  def initialize(body)
    @body = body
    @trace = []
  end

  def body=(body)
    throw :typeError unless body.is_a?(String)
    @body = body
  end

  def body
    @body
  end

  def trace=(trace)
    throw :typeError unless trace.is_a?(Array)
    trace.each { |item|
      throw :typeError unless item.is_a?(Location)
      throw :duplicateError if @trace.include?(item)
      @trace.push(item)
    }
  end

  def trace
    @trace
  end
end