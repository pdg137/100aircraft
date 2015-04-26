class Aircraft
  attr_reader :name, :picture, :description, :length_ft

  def wikipedia_name
    @wikipedia_name || @name
  end
end
