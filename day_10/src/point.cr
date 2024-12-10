class Point
  getter height : Int32
  property neighbours : Array(Point)

  def initialize(@height)
    @neighbours = [] of Point
  end

  def trailhead?
    @height == 0
  end

  def reachable_neighbours
    @neighbours.select { |neighbour| (neighbour.height - @height) == 1 }
  end
end

