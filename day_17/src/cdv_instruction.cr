class CdvInstruction
  include Instruction

  def perform(operand : Operand, context : Context)
    context.registers['C'].value = context.registers['A'].value // (2 ** operand.value)
  end
end

