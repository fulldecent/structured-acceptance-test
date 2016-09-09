#!/usr/bin/env ruby

require 'json'
require "json-schema"
require 'optparse'
require_relative 'version'

option = OptionParser.new do |option|
  option.banner = 'Usage: stat-reader <file>'

  option.on('-h', '--help', 'Print usage info') do
    puts option
    exit
  end

  option.on('-v', '--version', 'Print version info') do
    puts "stat-reader #{StatReader::VERSION}"
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

schema_path = File.dirname(__FILE__) + '/../../statJsonSchema.json'

if JSON::Validator.validate(schema_path, filename, :uri => true)
  content = File.read(filename)
  json = JSON.parse(content)

  number_of_findings = 0
  number_of_failures = 0
  number_of_findings_with_fixes = 0

  unless json['findings'].nil?
    json['findings'].each{ |finding|
      number_of_findings += 1
      if finding['failure']
        number_of_failures += 1
      end
      unless finding['fixes'].nil?
        number_of_findings_with_fixes += 1
      end
    }
  end

  puts 'Number of findings: ' + number_of_findings.to_s
  puts 'Number of failures: ' + number_of_failures.to_s
  puts 'Number of findings with fixes: ' + number_of_findings_with_fixes.to_s
else
  puts 'json schema validation failed'
end