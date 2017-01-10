class Finding
  @failure
  @rule
  @description
  @detail
  @categories
  @location
  @time_to_fix
  @recommendation
  @fixes

  def initialize(failure, rule, description)
    throw :typeError unless rule.is_a?(String) && description.is_a?(String)
    @failure = failure
    @rule = rule
    @description = description
    @categories = []
    @fixes = []
  end

  def failure=(failure)
    @failure = failure
  end

  def failure
    @failure
  end

  def rule=(rule)
    throw :typeError unless rule.is_a?(String)
    @rule = rule
  end

  def rule
    @rule
  end

  def description=(description)
    throw :typeError unless description.is_a?(String)
    @description = description
  end

  def description
    @description
  end

  def detail=(detail)
    throw :typeError unless detail.is_a?(Detail)
    @detail = detail
  end

  def detail
    @detail
  end

  def categories=(categories)
    throw :typeError unless categories.is_a?(Array)
    categories.each { |item|
      throw :typeError unless StatCategory.all.include?(item)
      throw :duplicateError if @categories.include?(item)
      @categories.push(item)
    }
  end

  def categories
    @categories
  end

  def location=(location)
    throw :typeError unless location.is_a?(Location)
    @location = location
  end

  def location
    @location
  end

  def time_to_fix=(time_to_fix)
    throw :typeError unless time_to_fix.is_a?(Integer)
    @time_to_fix = time_to_fix
  end

  def time_to_fix
    @time_to_fix
  end

  def recommendation=(recommendation)
    throw :typeError unless recommendation.is_a?(String)
    @recommendation = recommendation
  end

  def recommendation
    @recommendation
  end

  def fixes=(fixes)
    throw :typeError unless fixes.is_a?(Array)
    @fixes.each { |item|
      throw :typeError unless item.is_a?(Fix)
      throw :duplicateError if @fixes.include?(item)
      @fixes.push(item)
    }
  end

  def fixes
    @fixes
  end
end