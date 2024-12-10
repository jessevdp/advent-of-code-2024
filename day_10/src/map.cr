class Map
  @rows : Array(Array(Point))

  def initialize(@rows)
  end

  def self.from_input(lines : Array(String))
    rows = lines.map do |line|
      line.chars.map do |height|
        Point.new(height.to_i)
      end
    end
    new(rows)
  end

  def points
    @rows.flatten
  end

  def point(x, y)
    return if x < 0 || x >= width
    return if y < 0 || y >= height

    @rows[y][x]
  end

  def point!(x, y)
    point(x, y).not_nil!
  end

  def width
    return 0 unless @rows.any?

    @rows.first.size
  end

  def height
    @rows.size
  end
end

