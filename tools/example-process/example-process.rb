#!/usr/bin/env ruby
require 'stat'

process = StatModule::Process.new('One two three example process')
stat = StatModule::Stat.new(process)

finding_one = StatModule::Finding.new(false, 'Go to your room', 'I told you once')
finding_two = StatModule::Finding.new(false, 'Go to your room', 'I told you twice')
finding_three = StatModule::Finding.new(true, 'Go to your room', 'I told you three times')

stat.print_header
sleep 1

stat.findings.push(finding_one)
stat.print_finding
sleep 2

stat.findings.push(finding_two)
stat.print_finding
sleep 3

stat.findings.push(finding_three)
stat.print_finding
stat.print_footer
