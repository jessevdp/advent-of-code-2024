enum Axis
  Horizontal
  Vertical

  def opposite
    case self
    when Horizontal then Vertical
    else Horizontal
    end
  end
end


