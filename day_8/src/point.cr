record Point, x : Int32, y : Int32 do
  def -(other : Point) : Delta
    Delta.new(
      x: x - other.x,
      y: y - other.y,
      )
  end

  def +(delta : Delta) : Point
    copy_with(
      x: x + delta.x,
      y: y + delta.y,
    )
  end

  def -(delta : Delta) : Point
    copy_with(
      x: x - delta.x,
      y: y - delta.y,
    )
  end

  # def in_bounds_of?(map : Map)
  #   map.in_bounds?(self)
  # end
end

# struct Point::Delta
#   getter x, y
#
#   def initialize(x : Int32, y : Int32)
#     @x = x.abs
#     @y = y.abs
#   end
# end

record Point::Delta, x : Int32, y : Int32

