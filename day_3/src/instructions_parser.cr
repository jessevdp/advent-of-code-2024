class MulInstruction < Instruction
  getter a, b

  def initialize(@a : Int32, @b : Int32)
  end

  def execute : Int32
    @a * @b
  end
end

class InstructionSet < Instruction
  def initialize(@instructions = [] of Instruction)
  end

  def result
    result = 0
    @instructions.each do |instruction|
      result += instruction.result
    end
    result
  end
end

class InstructionsParser
  def initialize(@input : String)
  end

  def extract_valid_instructions
    @input.scan(/mul\(\d+,\d+\)/m).map(&.to_s)
  end

  def parse
    instructions = [] of Instruction
    extract_valid_instructions.each do |raw_instruction|
      match = raw_instruction.match!(/(?<a>\d+),(?<b>\d+)/)
      a = match["a"].to_i
      b = match["b"].to_i
      instructions << MulInstruction.new(a, b)
    end

    InstructionSet.new(instructions)
  end
end

