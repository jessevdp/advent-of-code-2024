class Program::DoInstruction < Program::Instruction
  def execute(context)
    context.enable
    0
  end

  def ==(other)
    other.is_a?(Program::DoInstruction)
  end
end

