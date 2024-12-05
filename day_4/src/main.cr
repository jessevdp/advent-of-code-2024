require "./character_grid"

def part_one(grid)
  word = "XMAS"
  count = 0
  grid.cells.each do |cell|
    CharacterGrid::Direction.each do |direction|
      value = cell.value_in_direction(direction, length: word.size)
      count += 1 if value == word
    end
  end

  puts "Part 1:"
  puts count
end

def part_two(grid)
  word = "MAS"
  count = 0

  axis_1_directions = [:down_right, :up_left] of CharacterGrid::Direction
  axis_2_directions = [:down_left, :up_right] of CharacterGrid::Direction
  axis_1_directions.each_cartesian(axis_2_directions) do |axis_1_direction, axis_2_direction|
    grid.cells.each do |cell|
      axis_1 = cell.value_in_direction(axis_1_direction, length: word.size, offset: -1)
      axis_2 = cell.value_in_direction(axis_2_direction, length: word.size, offset: -1)
      count += 1 if axis_1 == word && axis_2 == word
    end
  end

  puts "Part 2:"
  puts count
end

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

grid = CharacterGrid.new(lines)

part_one(grid)
part_two(grid)

