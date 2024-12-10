class Point
  getter height : Int32
  property neighbours : Array(Point)

  def initialize(@height)
    @neighbours = [] of Point
  end
end

