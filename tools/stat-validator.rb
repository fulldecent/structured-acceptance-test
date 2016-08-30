#!/usr/bin/env ruby

require 'json'
require "json-schema"
require 'optparse'
require_relative 'version'

option = OptionParser.new do |option|
    option.banner = 'Usage: stat-validator <file>'

    option.on('-h', '--help', 'Print usage info') do
        puts option
        exit
    end

    option.on('-v', '--version', 'Print version info') do
        puts "stat-validator #{StatValidator::VERSION}"
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
schema_path = File.dirname(__FILE__) + '/../statJsonSchema.json'

puts JSON::Validator.fully_validate(schema_path, filename, :uri => true)
