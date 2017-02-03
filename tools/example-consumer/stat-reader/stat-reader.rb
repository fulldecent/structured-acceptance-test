#!/usr/bin/env ruby
require 'json'
require "json-schema"
require 'optparse'
require_relative 'version'

require_relative '../../../implementations/ruby/lib/stat'

def valid_json?(json)
  begin
    JSON.parse(json)
    return true
  rescue JSON::ParserError => e
    return false
  end
end

option = OptionParser.new do |option|
  option.banner = 'Usage: example-consumer <file>'

  option.on('-h', '--help', 'Print usage info') do
    puts option
    exit
  end

  option.on('-v', '--version', 'Print version info') do
    puts "example-consumer #{StatReader::VERSION}"
    exit
  end
end

option.parse!

filename =
    if ARGV.length > 0
      ARGV[0]
    else
      if STDIN.tty?
        puts option
        exit
      end
    end

stat = nil
if !filename.nil?
  content = File.read(filename)
  hash = JSON.parse(content)
  stat = StatModule::Stat.new(nil, hash)
else
  block = ''
  ARGF.each_line { |line|
    block += line
    # first block - header
    if stat.nil? && valid_json?(block + ']}')
      block += ']}'
      stat = StatModule::Stat.new(nil, StatModule::Stat::from_json!(block))
      block = ''
    else
      # second block - findings
      if !stat.nil? && valid_json?(block.chomp(",\n"))
        finding = StatModule::Finding.new(nil, nil, nil, StatModule::Finding::from_json!(block.chomp(",\n")))
        stat.findings.push(finding)
        block = ''

        if finding.failure
          message = 'FAILURE'
        else
          message = 'WARNING'
        end
        puts "#{message}: #{finding.description}"
      end
    end

    STDOUT.flush
  }
end

unless stat.nil?
  warnings = 0
  failures = 0
  stat.findings.each { |finding|
    if finding.failure
      failures += 1
    else
      warnings += 1
    end
  }
  puts "SUMMARY: #{warnings} warnings, #{failures} failure"
end