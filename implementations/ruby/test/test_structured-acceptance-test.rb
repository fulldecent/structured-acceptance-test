require 'minitest/autorun'
require_relative '../lib/structured-acceptance-test'

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

  def test_stat_print_out_of_bound
    @finding1 = StatModule::Finding.new(true, 'some rule', 'some description')
    @finding2 = StatModule::Finding.new(true, 'some rule2', 'some description2')
    @stat.findings =[@finding1, @finding2]
    assert_raises StatModule::IndexOutOfBoundException do
      @stat.print_header
      @stat.print_finding
      @stat.print_finding
      @stat.print_finding
    end
  end
end