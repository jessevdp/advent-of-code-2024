require "./disk"
require "./disk_map_parser"
require "./individual_block_disk_compactor"
require "./whole_file_disk_compactor"

line = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath).first
else
  ""
end

puts "Part 1:"
disk = Disk.from_disk_map(line)
disk.compact(IndividualBlockDiskCompactor)
puts disk.checksum

puts "Part 2:"
disk = Disk.from_disk_map(line)
disk.compact(WholeFileDiskCompactor)
puts disk.checksum

