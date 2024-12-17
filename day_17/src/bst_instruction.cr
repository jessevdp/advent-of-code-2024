class BstInstruction
  include Instruction

  def perform(operand : Operand, context : Context)
    context.registers['B'].value = operand.value % 8
  end
end
