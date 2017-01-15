#!/usr/bin/env ruby
require 'structured-acceptance-test'

process = StatModule::Process.new('One two three example process')
stat = StatModule::Stat.new(process)

finding_one = StatModule::Finding.new(false, 'Go to your room', 'I told you once')
finding_two = StatModule::Finding.new(false, 'Go to your room', 'I told you twice')
finding_three = StatModule::Finding.new(true, 'Go to your room', 'I told you three times')

stat.findings = [finding_one, finding_two, finding_three]

stat.print_header
#sometimes output buffered
$stdout.flush
sleep 1

stat.print_finding
$stdout.flush
sleep 2

stat.print_finding
$stdout.flush
sleep 3

stat.print_finding
stat.print_footer
