class ProgramParser
  def initialize(@lines = [] of String)
  end

  def parse
    instructions = [] of Program::Instruction

    @lines.each do |line|
      matches = line.scan(/mul\((?<a>\d+),(?<b>\d+)\)/)
      matches.each do |match|
        a = match["a"].to_i
        b = match["b"].to_i
        instructions << Program::MulInstruction.new(a, b)
      end
    end

    Program.new(instructions)
  end
end
