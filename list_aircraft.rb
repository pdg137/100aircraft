#!/usr/bin/env ruby

require 'open-uri'
require 'json'

def parse(section)
  list_json = JSON.parse open("http://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=json&titles=#{section}").read
  pages = list_json['query']['pages']
  pages.each_value do |page|
    revisions = page['revisions']
    revisions.each do |revision|
      revision = revision['*']
      puts revision
    end
  end
end

parse('List_of_unmanned_aerial_vehicles')
parse('List_of_rotorcraft')
(['0-A']+('B'..'Z').to_a).each do |letter|
  parse("List_of_aircraft_(#{letter})")
end
