class Program::DontInstruction < Program::Instruction
  def execute(context)
    context.disable
    0
  end

  def ==(other)
    other.is_a?(Program::DontInstruction)
  end
end

