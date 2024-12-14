class Robot
  getter position : Point
  getter velocity : Vector2d

  def initialize(@position, @velocity)
  end

  def self.from_input(line : String)
    match = line.match!(/p=(?<x>\d+),(?<y>\d+) v=(?<dx>-?\d+),(?<dy>-?\d+)/)
    position = Point.new(
      x: match["x"].to_i,
      y: match["y"].to_i,
    )
    velocity = Vector2d.new(
      dx: match["dx"].to_i,
      dy: match["dy"].to_i,
    )
    new(position, velocity)
  end
end

