module Instruction
  abstract def perform(operand : Operand, context : Context)
  abstract def operand_type : Operand.class
end

