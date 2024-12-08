class MapParser
  def initialize(@lines : Array(String))
  end

  def parse
    antennas = [] of Antenna

    @lines.each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        next if char == '.'
        antennas << Antenna.new(char, Point.new(x, y))
      end
    end

    height = @lines.size
    width = @lines.any? ? @lines.first.size : 0

    Map.new(antennas, width, height)
  end
end

