class BxcInstruction
  include Instruction

  def operand_type : Operand.class
    LiteralOperand.as(Operand.class)
  end

  def perform(operand : Operand, context : Context)
    context.registers['B'].value ^= context.registers['C'].value
  end
end
