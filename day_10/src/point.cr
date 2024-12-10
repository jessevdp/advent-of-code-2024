class Point
  getter height : Int32
  property neighbours : Array(Point)

  def initialize(@height)
    @neighbours = [] of Point
  end

  def trailhead?
    @height == 0
  end

  def trailend?
    @height == 9
  end

  def reachable_neighbours
    @neighbours.select { |neighbour| (neighbour.height - @height) == 1 }
  end

  def reachable_trailends
    return Set{self} if trailend?

    trailends = Set(Point).new

    reachable_neighbours.each do |neighbour|
      trailends += neighbour.reachable_trailends
    end

    trailends
  end
end

