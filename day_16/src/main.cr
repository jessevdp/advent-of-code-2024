require "./priority_queue"

enum Direction
  North
  South
  East
  West

  def dx
    case self
    when West then 1
    when East then -1
    else 0
    end
  end

  def dy
    case self
    when North then -1
    when South then 1
    else 0
    end
  end

  def turn_right
    case self
    when North then East
    when East then South
    when South then West
    else North
    end
  end

  def turn_left
    case self
    when North then West
    when West then South
    when South then East
    else North
    end
  end
end

record Point,
  x : Int32,
  y : Int32 do

  def +(direction : Direction)
    copy_with(
      x: x + direction.dx,
      y: y + direction.dy,
    )
  end

  def manhattan_distance_to(other : Point)
    (other.x - x).abs + (other.y - y).abs
  end
end

record MazePath,
  current_position : Point,
  current_direction : Direction,
  total_cost : Int32 do

  def estimated_total_cost_to(point : Point)
    total_cost + current_position.manhattan_distance_to(point)
  end

  def +(action : Action)
    action.apply_to(self)
  end
end

abstract class Action
  abstract def apply_to(path : MazePath) : MazePath
  abstract def possible?(path : MazePath, map : Map) : Bool
  abstract def cost : Int32
end

class MoveForward < Action
  def cost : Int32
    1
  end

  def apply_to(path : MazePath) : MazePath
    path.copy_with(
      current_position: destination(path),
      total_cost: path.total_cost + cost,
    )
  end

  def possible?(path : MazePath, map : Map) : Bool
    destination = destination(path)
    map.tile(destination) == TileType::Empty
  end

  private def destination(path)
    path.current_position + path.current_direction
  end
end

abstract class TurnAction < Action
  def cost : Int32
    1000
  end

  def apply_to(path : MazePath) : MazePath
    path.copy_with(
      current_direction: direction(path),
      total_cost: path.total_cost + cost,
    )
  end

  def possible?(path : MazePath, map : Map) : Bool
    true
  end

  abstract def direction(path : MazePath) : Direction
end

class TurnLeft < TurnAction
  def direction(path : MazePath) : Direction
    path.current_direction.turn_left
  end
end

class TurnRight < TurnAction
  def direction(path : MazePath) : Direction
    path.current_direction.turn_right
  end
end

enum TileType
  Empty
  Wall
end

class Map
  getter start : Point
  getter finish : Point

  @rows : Array(Array(TileType))

  def initialize(@rows, @start, @finish)
  end

  def tile(point : Point)
    return unless in_bounds?(point)

    @rows[point.y][point.x]
  end

  def in_bounds?(point : Point)
    return false if point.x < 0 || point.x > width
    return false if point.y < 0 || point.y > height

    true
  end

  def width
    return 0 unless @rows.any?

    @rows.first.size
  end

  def height
    @rows.size
  end

  def lowest_possible_score
    actions = [
      MoveForward.new,
      TurnLeft.new,
      TurnRight.new,
    ]

    queue = PriorityQueue(MazePath).new do |path|
      path.estimated_total_cost_to(finish)
    end

    queue << MazePath.new(
      current_position: start,
      current_direction: Direction::East,
      total_cost: 0,
    )

    visited = Set(Tuple(Point, Direction)).new
    while queue.any?
      path = queue.shift

      next if visited.includes?({ path.current_position, path.current_direction })
      visited << { path.current_position, path.current_direction }

      return path.total_cost if path.current_position == finish

      actions.each do |action|
        queue << path + action if action.possible?(path, map: self)
      end
    end
  end
end

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

start = Point.new(0, 0)
finish = Point.new(0, 0)
rows = lines.map_with_index do |row, y|
  row.chars.map_with_index do |char, x|
    start = Point.new(x, y) if char == 'S'
    finish = Point.new(x, y) if char == 'E'
    char == '#' ? TileType::Wall : TileType::Empty
  end
end

map = Map.new(rows, start, finish)

puts "Part 1:"
puts map.lowest_possible_score

