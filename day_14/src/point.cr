record Point,
  x : Int32,
  y : Int32 do

  def +(vector : Vector2d)
    copy_with(
      x: x + vector.dx,
      y: y + vector.dy,
    )
  end
end

