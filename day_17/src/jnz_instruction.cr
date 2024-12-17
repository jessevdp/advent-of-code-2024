class JnzInstruction
  include Instruction

  def perform(operand : Operand, context : Context)
    return if context.registers['A'].value == 0

    context.instruction_pointer = operand.value
  end
end

