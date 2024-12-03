class Program
  getter instructions

  def initialize(@instructions : Array(Program::Instruction))
  end

  def execute
    context = Program::Context.new
    results = @instructions.map do |instruction|
      result = instruction.execute(context)
      context.enabled? ? result : nil
    end
    results.compact.sum
  end
end

class Program::Context
  def initialize(@enabled = true)
  end

  def enabled?
    @enabled
  end

  def enable
    @enabled = true
  end

  def disable
    @enabled = false
  end
end

abstract class Program::Instruction
  abstract def execute(context : Program::Context)
  abstract def ==(other : Program::Instruction)
end

