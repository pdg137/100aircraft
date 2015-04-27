require_relative 'lib/aircraft'
require_relative 'lib/format'
require_relative 'lib/aircraft_decorator'
require 'yaml'

format = Format.new(File.open('index.html', 'w'))

format.wrap do |file|
  format.section 'Airliners'
  AircraftCollectionDecorator.new(YAML.load_file('airliners.yml')).render(file)

  format.section 'Helicopters'
  AircraftCollectionDecorator.new(YAML.load_file('helicopters.yml')).render(file)

  format.section 'General Aviation'
  AircraftCollectionDecorator.new(YAML.load_file('general_aviation.yml')).render(file)

  format.section 'Military Jets'
  AircraftCollectionDecorator.new(YAML.load_file('military_jets.yml')).render(file)

  format.section 'Military Transport'
  AircraftCollectionDecorator.new(YAML.load_file('military_transport.yml')).render(file)

  format.section 'Extreme Planes'
  AircraftCollectionDecorator.new(YAML.load_file('extreme_planes.yml')).render(file)
end
