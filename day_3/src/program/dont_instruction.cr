class Program::DontInstruction < Program::Instruction
  def execute(context : Program::Context)
    0
  end

  def ==(other : Program::Instruction)
    other.is_a?(Program::DontInstruction)
  end
end

