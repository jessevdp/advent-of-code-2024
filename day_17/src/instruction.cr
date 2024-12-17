module Instruction
  abstract def perform(operand : Operand, context : Context)
end

