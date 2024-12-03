class Program
  getter instructions

  def initialize(@instructions : Array(Program::Instruction))
  end

  def execute
    @instructions.sum { |instruction| instruction.execute }
  end
end

abstract class Program::Instruction
  abstract def execute
  abstract def ==(other : Program::Instruction)
end

