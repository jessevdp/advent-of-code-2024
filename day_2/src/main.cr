require "./report"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

reports = lines.map do |line|
  levels = line.split.map(&.to_i)
  Report.new(levels)
end

puts "Part 1:"
puts reports.count(&.safe?)

