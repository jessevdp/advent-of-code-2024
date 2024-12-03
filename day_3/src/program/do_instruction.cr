class Program::DoInstruction < Program::Instruction
  def execute
    0
  end

  def ==(other : Program::Instruction)
    other.is_a?(Program::DoInstruction)
  end
end

