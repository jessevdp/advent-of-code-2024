class BxlInstruction
  include Instruction

  def perform(operand : Operand, context : Context)
    context.registers['B'].value ^= operand.value
  end
end
