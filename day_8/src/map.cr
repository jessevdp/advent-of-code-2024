class Map
  @antennas : Array(Antenna)
  @width : Int32
  @height : Int32

  def initialize(@antennas, @width, @height)
  end

  def in_bounds?(point : Point)
    return false if point.x < 0 || point.x >= @width
    return false if point.y < 0 || point.y >= @height

    true
  end

  def antinode_locations
    antinodes = Set(Point).new

    @antennas.group_by(&.frequency).each do |frequency, antennas|
      antennas.each_combination(2) do |(antenna_1, antenna_2)|
        antinodes += antinodes_for(antenna_1, antenna_2)
      end
    end

    antinodes
  end

  def antinodes_for(antenna_1, antenna_2)
    antinodes = Set(Point).new

    delta = antenna_2.location - antenna_1.location

    location = antenna_1.location
    while in_bounds?(location)
      antinodes << location
      location += delta
    end

    location = antenna_1.location - delta
    while in_bounds?(location)
      antinodes << location
      location -= delta
    end

    antinodes
  end
end

