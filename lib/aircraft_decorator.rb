class AircraftCollectionDecorator
  include Enumerable
  def initialize(collection)
    @collection = collection
    @max_picture_width_ft = collection.map(&:picture_width_ft).max
  end

  def each
    @collection.each do |aircraft|
      yield AircraftDecorator.new aircraft, max_picture_width_ft: @max_picture_width_ft
    end
  end

  def column(n)
    each_slice(2).map {|a| a[n]}.select(&:itself)
  end

  def render(file)
    file << <<END
<div class="left-col">
END
    column(0).each do |aircraft|
      file << aircraft.render
    end
    file << <<END
</div>
<div class="right-col">
END
    column(1).each do |aircraft|
      file << aircraft.render
    end
    file << <<END
</div>
END
  end

end

class AircraftDecorator
  attr_reader :max_picture_width_ft

  def url_encode(string)
    string.gsub(/['"&<>]/) { |s| '%'+(s.unpack('H*')[0])}
  end

  def initialize(aircraft, params)
    @aircraft = aircraft
    @max_picture_width_ft = params[:max_picture_width_ft]
  end

  def name
    @aircraft.name
  end

  def description
    @aircraft.description
  end

  def width_percent
    100 * @aircraft.picture_width_ft / max_picture_width_ft
  end

  def picture
    "<img style='width: #{width_percent}%' src='pictures/#{url_encode @aircraft.wikipedia_name}/#{url_encode @aircraft.picture}'>"
  end

  def float_side
    case @aircraft.direction
    when 'left'
      'right'
    else
      'left'
    end
  end

  def render
    <<END
<div class="aircraft #{float_side}">
#{picture}
<h3>#{name}</h3>
<p>
#{description}
</p>
</div>
END
  end
end
