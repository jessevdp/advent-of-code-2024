class BdvInstruction
  include Instruction

  def operand_type : Operand.class
    ComboOperand.as(Operand.class)
  end


  def perform(operand : Operand, context : Context)
    context.registers['B'].value = context.registers['A'].value // (2 ** operand.value)
  end
end

