class Aircraft
  attr_reader :name, :picture, :description, :length_ft, :width_ft, :pitch, :yaw, :direction

  def apparent_width_ft
    y = yaw || 0
    (width_ft || 0) * Math.sin(y * Math::PI/180)
  end

  def apparent_length_ft
    raise "#{name} does not have length_ft defined" if !length_ft

    p = pitch || 0
    y = yaw || 0
    length_ft * Math.cos(p * Math::PI/180) * Math.cos(y * Math::PI/180)
  end

  def picture_width_ft
    [apparent_length_ft, apparent_width_ft].max
  end

  def wikipedia_name
    @wikipedia_name || @name
  end
end
