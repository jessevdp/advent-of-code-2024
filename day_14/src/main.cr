require "./point"
require "./vector2d"
require "./bounding_box"
require "./robot"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

robots = lines.map { |line| Robot.from_input(line) }

