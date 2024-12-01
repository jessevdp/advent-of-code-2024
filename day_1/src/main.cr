require "./location_list"
require "./side_by_side_location_list_parser"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

list_1, list_2 = SideBySideLocationListParser.new(lines).parse
puts list_1.difference_to(list_2)

