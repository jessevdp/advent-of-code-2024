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


def reverse_engineer_output(program, a_value)
  slice_of_A_to_output = {} of Int32 => Int32

  contents = program.contents
  register_values = program.context.registers.transform_values(&.value)
  8.times do |n|
    register_values['A'] = n
    registers = register_values.transform_values { |value| Register.new(value) }
    program = Program.new(contents, registers)
    program.run
    raise "3 bit number returned more than 1 output" if program.context.output.size > 1
    slice_of_A_to_output[n] = program.context.output.first
  end

  a_value.to_s(2).chars.reverse.in_slices_of(3).map do |bits|
    slice_of_A_value = bits.reverse.join.to_i(2)
    slice_of_A_to_output[slice_of_A_value]
  end.join(',')
end

contents = program.contents
register_values = program.context.registers.transform_values(&.value)
100.times do |n|
  register_values['A'] = n
  registers = register_values.transform_values { |value| Register.new(value) }
  program = Program.new(contents, registers)
  program.run
  puts "A: #{n} base2:'#{n.to_s(2)}' base8: '#{n.to_s(8)}'"
  puts "program output: #{program.output}"
  puts "reverse engineered: #{reverse_engineer_output(program, n)}"
  puts ""
end
