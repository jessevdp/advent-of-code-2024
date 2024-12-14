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

def draw_grid(robots, bounds)
  lines = [] of String
  bounds.height.times do |y|
    line = ""
    bounds.width.times do |x|
      point = Point.new(x, y)
      filled = robots.any? { |robot| robot.position == point }
      line += filled ? 'X' : '.'
    end
    lines << line
  end
  lines
end

def part_2(lines)
  bounds = BoundingBox.of_dimensions(width: 101, height: 103)
  robots = lines.map { |line| Robot.from_input(line, bounds) }

  seconds = 0
  100_000.times do
    seconds += 1
    robots.each(&.tick)
    filepath = "./output/#{seconds}.txt"
    File.open(filepath, "w") do |file|
      file.puts "===================="
      file.puts "seconds: #{seconds}"
      file.puts "===================="
      file.puts draw_grid(robots, bounds).join('\n')
      file.puts ""
    end
  end
end

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

part_1(lines)
part_2(lines)
