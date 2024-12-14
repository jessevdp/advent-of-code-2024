require "./point"
require "./vector2d"
require "./bounding_box"
require "./robot"

def part_1(lines)
  bounds = BoundingBox.of_dimensions(width: 101, height: 103)
  robots = lines.map { |line| Robot.from_input(line, bounds) }

  robots.each do |robot|
    100.times do
      robot.tick
    end
  end

  quadrants = bounds.quadrants

  robot_counts = quadrants.map do |quadrant|
    robots.count { |robot| quadrant.contains?(robot.position) }
  end

  puts "Part 1:"
  puts robot_counts.reduce(1) { |acc, i| acc * i }
end

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

part_1(lines)
