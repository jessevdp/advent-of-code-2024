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
end

