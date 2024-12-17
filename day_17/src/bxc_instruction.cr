class BxcInstruction
  include Instruction

  def perform(operand : Operand, context : Context)
    context.registers['B'].value ^= context.registers['C'].value
  end
end
