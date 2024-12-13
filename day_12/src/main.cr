require "./plot"
require "./edge"
require "./direction"
require "./region"
require "./map"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

map = Map.from_input(lines)

puts "Part 1:"
puts map.regions.map { |region| region.area * region.perimeter }.sum

