record Trail, points : Array(Point) do
  def start
    @points.first
  end

  def end
    @points.last
  end

  def +(point : Point)
    copy_with(
      points: @points.unshift(point),
    )
  end
end

