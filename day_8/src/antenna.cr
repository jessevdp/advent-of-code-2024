class Antenna
  getter frequency : Char
  getter location : Point

  def initialize(@frequency, @location)
  end

  # def antinodes(other)
  #   delta = other.location - location
  #   [
  #     location - delta,
  #     other.location + delta,
  #   ]
  # end
end

