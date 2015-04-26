class Aircraft
  attr_reader :name, :picture, :description, :length_ft, :pitch, :yaw, :direction

  def apparent_length_ft
    length_ft * Math.cos(pitch * Math::PI/180) * Math.cos(yaw * Math::PI/180)
  end

  def wikipedia_name
    @wikipedia_name || @name
  end
end
