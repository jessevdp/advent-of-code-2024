class BxlInstruction
  include Instruction

  def operand_type : Operand.class
    LiteralOperand.as(Operand.class)
  end

  def perform(operand : Operand, context : Context)
    context.registers['B'].value ^= operand.value
  end
end
