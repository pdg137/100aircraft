#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'csv'

csv = CSV.open('values.csv','w')

Dir.chdir('aircraft')
Dir.glob('*').each do |aircraft|
  infobox = File.read aircraft

  if infobox =~ /\|\s*number built= *(.*)/
    number_built_text = $1

    infobox =~ /\A.*\|\s*unit cost= *([^\n]*)/m # get the last match
    cost_text = $1 || "300000" # 300k is a safe minimum guess

    cost_text.gsub %r(<ref>[^<]+</ref>), ''

    cost = case cost_text
           when /\A<!--Incremental/
             # nothing
             300000
           when /.*€([0-9,.]+)m/
             ($1.to_f * 1.22 * 1e6).round # Euro exchange rate
           when /.*USD\|([0-9,.]+)/
             ($1.sub(',','').to_f).round
           when /.*(?<![.\d])([\d,.]+) million/
             ($1.sub(',','').to_f * 1e6).round
           when /.*(?<![.\d])([0-9,.]+)&nbsp;million/
             ($1.sub(',','').to_f * 1e6).round
           when /.*(?<![.\d])([0-9,.]+)&nbsp;\(€[0-9,.]+\) million/
             ($1.sub(',','').to_f * 1e6).round
           when /.*(?<![.\d])([0-9,.]+M)/
             ($1.sub(',','').to_f * 1e6).round
           when /.*\$\]?\]?([0-9,.]+)/
             ($1.sub(',','').to_f).round
           when /(?<![.\d])([0-9,.]+)/
             ($1.sub(',','').to_f).round
           else
             300000
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
