require "./disk"
require "./disk_map_parser"
require "./disk_compactor"

line = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath).first
else
  ""
end

disk = Disk.from_disk_map(line)

puts "Part 1:"
disk.compact
puts disk.checksum

