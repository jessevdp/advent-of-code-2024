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

class Patrol
  @grid : Grid
  @start_position : Coordinate
  @start_direction : Direction

  getter visited_coordinates

  def initialize(@grid, @start_position, @start_direction)
    @visited_coordinates = Set(Coordinate).new
  end

  def simulate
    @visited_coordinates.clear

    current_direction = @start_direction
    current_position = @start_position
    while current_position.in_bounds_of?(@grid)
      @visited_coordinates << current_position
      next_position = current_position + current_direction

      if @grid.cell_at(next_position) == Grid::Cell::Obstacle
        current_direction = current_direction.next_direction
      else
        current_position = next_position
      end
    end

    @visited_coordinates
  end
end

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

start_position = Coordinate.new(x: 0, y: 0)
rows = lines.map_with_index do |line, y|
  line.chars.map_with_index do |char, x|
    case char
    when '#' then Grid::Cell::Obstacle
    when '^'
      start_position = Coordinate.new(x, y)
      Grid::Cell::Empty
    else Grid::Cell::Empty
    end
  end
end

grid = Grid.new(rows)
patrol = Patrol.new(grid, start_position, Direction::Up)

puts "Part 1:"
patrol.simulate
puts patrol.visited_coordinates.size

