require_relative 'lib/aircraft'
require_relative 'lib/format'
require_relative 'lib/aircraft_decorator'
require 'yaml'

file = File.open('index.html', 'w')

format = Format.new
file << format.header

AircraftCollectionDecorator.new(YAML.load_file('airliners.yml')).render(file)

file << format.footer
