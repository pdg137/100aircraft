class AircraftCollectionDecorator
  include Enumerable
  def initialize(collection)
    @collection = collection
  end

  def each
    @collection.each do |aircraft|
      yield AircraftDecorator.new aircraft
    end
  end
end

class AircraftDecorator
  def initialize(aircraft)
    @aircraft = aircraft
  end

  def name
    @aircraft.name
  end

  def description
    @aircraft.description
  end

  def width_px
    @aircraft.length_ft
  end

  def picture
    "<img style='width: #{width_px}' src='pictures/#{@aircraft.wikipedia_name}/#{@aircraft.picture}'>"
  end

  def render
    <<END
<h2>#{name}</h2>
#{picture}
<p>
#{description}
</p>
END
  end
end
