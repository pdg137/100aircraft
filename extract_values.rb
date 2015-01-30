#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'

csv = CSV.open('values.csv','w')

def known_cost(aircraft)
  case aircraft
  when 'Gulfstream V'
    20e6 # saw ~15m on for sale sites
  when 'McDonnell Douglas MD-11'
    150e6 # saw on http://www.aircraftcompare.com/
  when 'Grumman F-11 Tiger', 'Xian JH-7'
    20e6 # safe minimum for a fighter
  when 'Dassault Falcon 2000'
    30e6 # 25e6 and 33e6 given on aircraftcompare.com
  when 'Dassault Falcon 90'
    35e6 # 34.5-39 on aircraftcompare.com
  when 'Ilyushin Il-76'
    50e6 # http://www.defenseindustrydaily.com/china-to-buy-38-il76-heavy-transports-il78-tankers-01180/
  else
    nil # 300k is a safe minimum guess
  end
end

Dir.chdir('aircraft')
Dir.glob('*').each do |aircraft|
  infobox = File.read aircraft

  if infobox =~ /\|\s*number built\s*=\s*(.*)/
    number_built_text = $1

    infobox =~ /\A.*\|\s*unit cost\s*=\s*([^\n]*)/m # get the last match

    cost_text = $1 || ''

    cost_text.gsub! %r(<ref>[^<]+</ref>), ''
    cost_text.gsub! /&nbsp;/, ' '
    cost_text.gsub! /\(€(\d)+\)/, ''
    cost_text.gsub! /\s+/, ' '

    cost = known_cost(aircraft) ||
      case cost_text
      when /\A<!--Incremental/
        0
      when /.*€([0-9,.]+)m/
        ($1.to_f * 1.22 * 1e6).round # Euro exchange rate
      when /.*US(D|\$)\|?([0-9,.]+(\s|&nbsp;)+million)/
        ($2.gsub(',','').to_f * 1e6).round
      when /.*US\s*\$\s*([0-9,.]+)-([0-9,.]+) million/
        ($2.gsub(',','').to_f * 1e6).round
      when /.*US\s*\$([0-9,.]+)/
        ($1.gsub(',','').to_f).round
      when /.*USD\|([0-9,.]+)/
        ($1.gsub(',','').to_f).round
      when /.*(?<![.\d])([\d,.]+) million/
        ($1.gsub(',','').to_f * 1e6).round
      when /.*(?<![.\d])([0-9,.]+)&nbsp;million/
        ($1.gsub(',','').to_f * 1e6).round
      when /.*(?<![.\d])([0-9,.]+)&nbsp;\(€[0-9,.]+\) million/
        ($1.gsub(',','').to_f * 1e6).round
      when /.*(?<![.\d])([0-9,.]+M)/
        ($1.gsub(',','').to_f * 1e6).round
      when /.*\$\]?\]?([0-9,.]+)/
        ($1.gsub(',','').to_f).round
      when /(?<![.\d])([0-9,.]+)/
        ($1.gsub(',','').to_f).round
      else
        0
      end

    if cost < 300000
      cost = 300000
    end

    next if number_built_text =~ /\A\s*\Z/

    number_built = case number_built_text
                   when /([0-9,]+)/
                     $1.sub(',','').to_i
                   else
                     0
                   end

    csv << [aircraft,number_built,cost,number_built*cost/1e7.round/100.0,cost_text]
  end
end
