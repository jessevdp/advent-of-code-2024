record BoundingBox,
  upper_left_bound : Point,
  lower_right_bound : Point do

  def self.of_dimensions(width, height)
    upper_left_bound = Point.new(0, 0)
    lower_right_bound = Point.new(
      x: width - 1,
      y: height - 1,
    )
    new(upper_left_bound, lower_right_bound)
  end
end

