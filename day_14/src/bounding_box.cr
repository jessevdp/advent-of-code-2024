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

  def width
    (lower_right_bound.x - upper_left_bound.x) + 1
  end

  def height
    (lower_right_bound.y - upper_left_bound.y) + 1
  end

  def wrap(point : Point)
    wrapped_x = upper_left_bound.x + ((point.x - upper_left_bound.x + width) % width)
    wrapped_y = upper_left_bound.y + ((point.y - upper_left_bound.y + height) % height)
    point.copy_with(
      x: wrapped_x,
      y: wrapped_y,
    )
  end

  def contains?(point : Point)
    return false if point.x < upper_left_bound.x || point.x > lower_right_bound.x
    return false if point.y < upper_left_bound.y || point.y > lower_right_bound.y

    true
  end

  def quadrants
    top_left = copy_with(
      lower_right_bound: lower_right_bound.copy_with(
        x: (width // 2) - 1,
        y: (height // 2) - 1,
      ),
    )
    bottom_left = copy_with(
      upper_left_bound: upper_left_bound.copy_with(
        y: (height // 2) + 1,
      ),
      lower_right_bound: lower_right_bound.copy_with(
        x: (width // 2) - 1,
      ),
    )
    top_right = copy_with(
      upper_left_bound: upper_left_bound.copy_with(
        x: (width // 2) + 1,
      ),
      lower_right_bound: lower_right_bound.copy_with(
        y: (height // 2) - 1,
      ),
    )
    bottom_right = copy_with(
      upper_left_bound: upper_left_bound.copy_with(
        x: (width // 2) + 1,
        y: (height // 2) + 1,
      ),
    )
    {top_left, bottom_left, top_right, bottom_right}
  end
end

