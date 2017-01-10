class StatProcess
  @name
  @version
  @description
  @maintainer
  @email
  @website
  @repeatability

  def initialize(name)
    throw :typeError unless name.is_a?(String)
    @name = name
  end

  def name=(name)
    throw :typeError unless name.is_a?(String)
    @name = name
  end

  def name
    @name
  end

  def version=(version)
    throw :typeError unless version.is_a?(String)
    @version = version
  end

  def version
    @version
  end

  def description=(description)
    throw :typeError unless description.is_a?(String)
    @description = description
  end

  def description
    @description
  end

  def maintainer=(maintainer)
    throw :typeError unless maintainer.is_a?(String)
    @maintainer = maintainer
  end

  def maintainer
    @maintainer
  end

  def email=(email)
    throw :typeError unless email.is_a?(String)
    @email = email
  end

  def email
    @email
  end

  def website=(website)
    throw :typeError unless website.is_a?(String)
    @website = website
  end

  def website
    @website
  end

  def repeatability=(repeatability)
    throw :typeError unless Repeatability.all.include?(repeatability)
    @repeatability = repeatability
  end

  def repeatability
    @repeatability
  end
end