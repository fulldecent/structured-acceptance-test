require_relative 'detail'
require_relative 'finding'
require_relative 'fix'
require_relative 'location'
require_relative 'stat_process'
require_relative 'repeatability'
require_relative 'stat_category'
require_relative 'JSONable'

class Stat < JSONable
  attr_reader :statVersion
  @findings
  @process

  def initialize(process)
    throw :typeError unless process.is_a?(StatProcess)
    @statVersion = '1.0.0'
    @process = process
    @findings = []
  end

  def findings=(findings)
    throw :typeError unless findings.is_a?(Array)
    findings.each { |item|
      throw :typeError unless item.is_a?(Finding)
      throw :duplicateError if @findings.include?(item)
      @findings.push(item)
    }
  end

  def findings
    @findings
  end

  def process=(process)
    throw :typeError unless process.is_a?(StatProcess)
    @process = process
  end

  def process
    @process
  end
end