class Program::MulInstruction < Program::Instruction
  getter a, b

  def initialize(@a : Int32, @b : Int32)
  end

  def execute(context)
    @a * @b
  end

  def ==(other : Program::Instruction)
    return false unless other.is_a?(Program::MulInstruction)
    return @a == other.a && @b == other.b
  end
end
