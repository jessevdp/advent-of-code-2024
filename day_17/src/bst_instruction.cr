class BstInstruction
  include Instruction

  def operand_type : Operand.class
    ComboOperand.as(Operand.class)
  end

  def perform(operand : Operand, context : Context)
    context.registers['B'].value = operand.value % 8
  end
end
