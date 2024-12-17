class OutInstruction
  include Instruction

  def operand_type : Operand.class
    ComboOperand.as(Operand.class)
  end

  def perform(operand : Operand, context : Context)
    context.output << operand.value % 8
  end
end
