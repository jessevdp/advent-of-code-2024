require "./character_grid"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

grid = CharacterGrid.new(lines)

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

