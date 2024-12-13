record Edge,
  x : Int32,
  y : Int32,
  direction : Direction do

  def axis_value(axis : Axis)
    axis.horizontal? ? x : y
  end
end

