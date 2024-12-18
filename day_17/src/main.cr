require "./register"
require "./context"

require "./operand"
require "./literal_operand"
require "./combo_operand"

require "./instruction"
require "./adv_instruction"
require "./bxl_instruction"
require "./bst_instruction"
require "./jnz_instruction"
require "./bxc_instruction"
require "./out_instruction"
require "./bdv_instruction"
require "./cdv_instruction"

require "./program"

require "./program_parser"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

program = ProgramParser.new(lines).parse

puts "Part 1:"
program.run
puts program.output

