class CharacterGrid
  @rows : Array(Array(Cell))

  def initialize(lines)
    @rows = lines.map do |line|
      line.chars.map { |char| Cell.new(char) }
    end
  end

  def cell_at(x, y)
    cell_at(Coordinate.new(x, y))
  end

  def cell_at(coordinate)
    return unless contains?(coordinate)

    @rows[coordinate.y][coordinate.x]
  end

  def value_at(x, y, length, direction : Direction)
    value_at(Coordinate.new(x, y), length, direction)
  end

  def value_at(coordinate, length, direction : Direction)
    coordinates = [coordinate]
    (length - 1).times do
      coordinates << coordinates.last + direction
    end

    return unless coordinates.all? { |c| contains?(c) }

    coordinates.map do |coordinate|
      cell_at(coordinate).not_nil!.content
    end.join
  end

  def contains?(coordinate)
    return false if coordinate.x < 0 || coordinate.x >= width
    return false if coordinate.y < 0 || coordinate.y >= height
    true
  end

  def width
    return 0 unless @rows.any?

    @rows.first.size
  end

  def height
    @rows.size
  end
end

class CharacterGrid::Coordinate
  getter x : Int32
  getter y : Int32
  def initialize(@x, @y)
  end

  def +(direction : Direction)
    self.class.new(
      x: x + direction.x_offset,
      y: y + direction.y_offset,
    )
  end
end

class CharacterGrid::Cell
  getter content : Char

  def initialize(@content)
  end
end

enum CharacterGrid::Direction
  Up
  UpRight
  Right
  DownRight
  Down
  DownLeft
  Left
  UpLeft

  def x_offset
    case self
    when .right?, .up_right?, .down_right?
      1
    when .left?, .up_left?, .down_left?
      -1
    else
      0
    end
  end

  def y_offset
    case self
    when .down?, .down_right?, .down_left?
      1
    when .up?, .up_right?, .up_left?
      -1
    else
      0
    end
  end
end
