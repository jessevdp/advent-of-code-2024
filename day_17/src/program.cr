class Program
  @contents : Array(Int32)

  def initialize(@contents, registers : Hash(Char, Register))
    @instruction_pointer = 0
    @context = Context.new(registers, @instruction_pointer)
  end

  def output
    @context.output.join(',')
  end

  def run
    while @instruction_pointer < (@contents.size - 1)
      prepare_context
      perform_instruction
      jump_or_increment_instruction_pointer
    end
  end

  private def prepare_context
    @context.instruction_pointer = @instruction_pointer
  end

  private INSTRUCTIONS = {
    0 => AdvInstruction.new,
    1 => BxlInstruction.new,
    2 => BstInstruction.new,
    3 => JnzInstruction.new,
    4 => BxcInstruction.new,
    5 => OutInstruction.new,
    6 => BdvInstruction.new,
    7 => CdvInstruction.new,
  }

  private def perform_instruction
    opcode = @contents[@instruction_pointer]
    instruction = INSTRUCTIONS[opcode]
    raw_operand = @contents[@instruction_pointer + 1]
    operand = instruction.operand_type.new(raw_operand, @context)
    instruction.perform(operand, @context)
  end

  private def jump_or_increment_instruction_pointer
    if previous_instruction_jumped?
      @instruction_pointer = @context.instruction_pointer
    else
      @instruction_pointer += 2
    end
  end

  private def previous_instruction_jumped?
    @context.instruction_pointer != @instruction_pointer
  end
end

