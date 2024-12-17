class OutInstruction
  include Instruction

  def perform(operand : Operand, context : Context)
    context.output << operand.value % 8
  end
end
