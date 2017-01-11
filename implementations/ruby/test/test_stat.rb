require 'minitest/autorun'
require_relative '../../../implementations/ruby/lib/stat'

class TestStat < Minitest::Test
  def setup
    @process = StatModule::Process.new('process name')
    @stat = StatModule::Stat.new(@process)
  end

  def test_findings_empty
    assert_equal 0, @stat.findings.length
  end

  def test_findings_not_empty
    @finding = StatModule::Finding.new(true, 'some rule', 'some description')
    @stat.findings = [@finding]
    assert_equal 1, @stat.findings.length
  end

  def test_finding_assertion
    assert_raises StatModule::TypeException do
      @stat.findings = "String"
    end
  end
end