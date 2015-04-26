require_relative 'lib/aircraft'
require_relative 'lib/aircraft_decorator'
require 'yaml'

file = File.open('index.html', 'w')

airliners = AircraftCollectionDecorator.new YAML.load_file('airliners.yml')
airliners.each do |airliner|
  file << airliner.render
end
