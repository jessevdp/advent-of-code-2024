enum Direction
  Up
  Right
  Down
  Left

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

  def next_direction : Direction
    case self
    when Up then Right
    when Right then Down
    when Down then Left
    else Up
    end
  end
end

record Coordinate, x : Int32, y : Int32 do
  def +(direction : Direction)
    copy_with(
      x: x + direction.delta_x,
      y: y + direction.delta_y,
    )
  end

  def in_bounds_of?(grid : Grid)
    grid.in_bounds?(self)
  end
end

class Grid
  @rows : Array(Array(Cell))

  def initialize(@rows)
    @width = @rows.any? ? @rows.first.size : 0
    @height = @rows.size
  end

  def cell_at(coordinate : Coordinate)
    return Cell::Empty unless in_bounds?(coordinate)

    @rows[coordinate.y][coordinate.x]
  end

  def in_bounds?(coordinate : Coordinate)
    return false if coordinate.x < 0 || coordinate.x >= @width
    return false if coordinate.y < 0 || coordinate.y >= @height

    true
  end
end

enum Grid::Cell
  Obstacle
  Empty
end

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

initial_position = Coordinate.new(x: 0, y: 0)
rows = lines.map_with_index do |line, y|
  line.chars.map_with_index do |char, x|
    case char
    when '#' then Grid::Cell::Obstacle
    when '^'
      initial_position = Coordinate.new(x, y)
      Grid::Cell::Empty
    else Grid::Cell::Empty
    end
  end
end

grid = Grid.new(rows)
direction = Direction::Up
current_position = initial_position
visited = Set(Coordinate).new

while current_position.in_bounds_of?(grid)
  visited << current_position
  next_position = current_position + direction

  if grid.cell_at(next_position) == Grid::Cell::Obstacle
    direction = direction.next_direction
  else
    current_position = next_position
  end
end

puts "Part 1:"
puts visited.size

