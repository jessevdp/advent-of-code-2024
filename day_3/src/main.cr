require "./program"
require "./program/mul_instruction"
require "./program/do_instruction"
require "./program/dont_instruction"
require "./program_parser"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

program = ProgramParser.new(lines).parse

puts "Part 1:"
puts program.execute

