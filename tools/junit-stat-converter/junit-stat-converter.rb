#!/usr/bin/env ruby

require 'optparse'
require_relative 'version'
require_relative 'stat'
require 'xmlsimple'

option = OptionParser.new do |option|
  option.banner = 'Usage: junit-stat-converter <file>'

  option.on('-h', '--help', 'Print usage info') do
    puts option
    exit
  end

  option.on('-v', '--version', 'Print version info') do
    puts "junit-stat-converter #{JUnitStatConverter::VERSION}"
    exit
  end
end

option.parse!

filename =
    if ARGV == []
      puts option
      exit
    else
      ARGV[0]
    end

hash = XmlSimple.xml_in(filename)

process = StatModule::Process.new('JUnit')
stat = StatModule::Stat.new(process)
findings = []

hash['testsuite'].each { |testsuite|
  testsuite['testcase'].each { |testcase|
    failure = false
    rule = testcase['name']
    description = ''
    unless testcase['failure'].nil?
      failure = true
      unless ['failure'].nil?
        description = testcase['failure'].first['message'] unless ['failure'].first.nil?
      end
    end
    finding = StatModule::Finding.new(failure, rule, description)
    findings.push(finding)
  } unless testsuite['testcase'].nil?
}

stat.findings = findings
puts stat.to_json

