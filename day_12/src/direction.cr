enum Direction
  Up
  Down
  Left
  Right

  def delta_x
    case self
    when Right then 1
    when Left then -1
    else 0
    end
  end

  def delta_y
    case self
    when Up then -1
    when Down then 1
    else 0
    end
  end

  def axis
    case self
    when Left, Right then Axis::Horizontal
    else Axis::Vertical
    end
  end
end

