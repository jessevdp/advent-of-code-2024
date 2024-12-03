class Program::DontInstruction < Program::Instruction
  def execute
    0
  end

  def ==(other : Program::Instruction)
    other.is_a?(Program::DontInstruction)
  end
end

