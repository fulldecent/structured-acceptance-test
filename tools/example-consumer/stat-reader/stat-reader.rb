#!/usr/bin/env ruby
require 'json'
require 'json-schema'
require 'optparse'
require 'stat'
require_relative 'version'

pretty_output = true

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

  option.on('-s', '--simple_output', 'Simple output') do
    pretty_output = false
  end

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

String.disable_colorization = true unless pretty_output

stat = nil
if !filename.nil?
  content = File.read(filename)
  hash = JSON.parse(content)
  stat = StatModule::Stat.new(nil, hash)
  puts stat.process.print(pretty_output)
  puts
  stat.findings.each{ |finding|
    puts finding.print(pretty_output)
    puts
  }
else
  block = ''
  ARGF.each_line { |line|
    block += line
    # first block - header
    if stat.nil? && valid_json?(block + ']}')
      block += ']}'
      stat = StatModule::Stat.new(nil, StatModule::Stat::from_json!(block))
      puts stat.process.print(pretty_output)
      puts
      block = ''
    else
      # second block - findings
      if !stat.nil? && valid_json?(block.chomp(",\n"))
        finding = StatModule::Finding.new(nil, nil, nil, StatModule::Finding::from_json!(block.chomp(",\n")))
        stat.findings.push(finding)
        puts finding.print(pretty_output)
        puts
        block = ''
      end
    end

    STDOUT.flush
  }
end

unless stat.nil?
  puts stat.summary_print(pretty_output)
end