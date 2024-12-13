record Point,
  x : Int32,
  y : Int32 do

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

