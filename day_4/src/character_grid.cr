class CharacterGrid
  def initialize(lines)
    @rows = [] of Array(Cell)
    @rows = lines.map_with_index do |line, y|
      line.chars.map_with_index do |char, x|
        Cell.new(char, Coordinate.new(x, y), grid: self)
      end
    end
  end

  def cells
    @rows.flatten
  end

  def cell_at(x, y)
    cell_at(Coordinate.new(x, y))
  end

  def cell_at(coordinate)
    return unless contains?(coordinate)

    @rows[coordinate.y][coordinate.x]
  end

  def value_at(x, y, length, direction : Direction, offset = 0)
    value_at(Coordinate.new(x, y), length, direction, offset)
  end

  def value_at(coordinate, length, direction : Direction, offset = 0)
    start_coordinate = coordinate.offset(direction, count: offset)

    coordinates = [start_coordinate]
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
    offset(direction, count: 1)
  end

  def offset(direction : Direction, count)
    self.class.new(
      x: x + (direction.x_offset * count),
      y: y + (direction.y_offset * count),
    )
  end
end

class CharacterGrid::Cell
  getter content : Char

  @coordinate : Coordinate
  @grid : CharacterGrid

  def initialize(@content, @coordinate, @grid)
  end

  def value_in_direction(direction : Direction, length, offset = 0)
    @grid.value_at(@coordinate, length, direction, offset)
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

