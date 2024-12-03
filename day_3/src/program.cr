class Program
  getter instructions

  def initialize(@instructions : Array(Program::Instruction))
  end

  def execute
    context = Program::Context.new
    @instructions.sum { |instruction| instruction.execute(context) }
  end
end

class Program::Context
end

abstract class Program::Instruction
  abstract def execute(context : Program::Context)
  abstract def ==(other : Program::Instruction)
end

