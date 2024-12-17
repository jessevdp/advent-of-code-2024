class AdvInstruction
  include Instruction

  def perform(operand : Operand, context : Context)
    context.registers['A'].value //= (2 ** operand.value)
  end
end

