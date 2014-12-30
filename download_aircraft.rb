#!/usr/bin/env ruby

require 'open-uri'
require 'json'

def parse(aircraft)
  puts "getting #{aircraft}..."
  json = JSON.parse open("http://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&rvsection=0&format=json&titles=#{URI.encode aircraft.sub('/','%3F')}&maxlag=5").read
  pages = json['query']['pages']
  pages.each_value do |page|
    revisions = page['revisions']
    if revisions
      revisions.each do |revision|
        revision = revision['*']

        if revision =~ /#REDIRECT \[\[([^#\]]*)/
          puts "get redirect -> #{$1}"
          parse($1)
        end

# Antonov An-12???
        if revision =~ /({{infobox aircraft type.*?^}})/mi
          infobox = $1
          if infobox =~ /number built\s*=.*[0-9]/i
            file = open("aircraft/#{aircraft.sub('/','%3F')}",'w')
            file.print infobox
            file.close
          else
            puts "minimal data for #{aircraft}"
          end
        else
          puts "nothing for #{aircraft}:"
          puts revision
        end
      end
    end
  end
end

open('list_of_aircraft.txt').each do |line|
  parse(line.chomp)
end

