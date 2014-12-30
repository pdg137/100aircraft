#!/usr/bin/env ruby

open('list_of_aircraft_raw.txt').each do |line|
  if line =~ /\*\[\[([^\]\|]*)\|?[^\]]*\]\]/ # || line =~ /\* \[\[([^\]\|]*)\|?[^\]]*\]\]/
    puts $1
  end
end
