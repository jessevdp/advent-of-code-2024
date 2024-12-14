record Point,
  x : Int64,
  y : Int64 do

  def +(action : Action)
    copy_with(
      x: x + action.dx,
      y: y + action.dy,
    )
  end

  def manhattan_distance(other : Point)
    (other.x - x).abs + (other.y - y).abs
  end
end

