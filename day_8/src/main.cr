require "./point"
require "./map"
require "./antenna"
require "./map_parser"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

map = MapParser.new(lines).parse

puts "Part 2:"
puts map.antinode_locations.size

