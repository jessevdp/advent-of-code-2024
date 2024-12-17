class JnzInstruction
  include Instruction

  def operand_type : Operand.class
    LiteralOperand.as(Operand.class)
  end

  def perform(operand : Operand, context : Context)
    return if context.registers['A'].value == 0

    context.instruction_pointer = operand.value
  end
end

