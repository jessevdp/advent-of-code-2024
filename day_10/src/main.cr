require "./point"
require "./trail"
require "./map"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

map = Map.from_input(lines)

puts "Part 1:"
puts map.total_score

puts "Part 2:"
puts map.total_rating

