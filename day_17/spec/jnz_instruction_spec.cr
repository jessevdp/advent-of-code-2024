require "./spec_helper"
require "./test_operand"

describe JnzInstruction do
  context "when A != 0" do
    it "sets the instruction_pointer to <operand>" do
      context = Context.new(
        registers: {
          'A' => Register.new(2),
        },
        instruction_pointer: 4,
      )
      operand = TestOperand.of_value(value: 12)
      JnzInstruction.new.perform(operand, context)
      context.instruction_pointer.should eq(12)
    end
  end

  context "when A == 0" do
    it "does nothing" do
      context = Context.new(
        registers: {
          'A' => Register.new(0),
        },
        instruction_pointer: 4,
      )
      operand = TestOperand.of_value(value: 12)
      JnzInstruction.new.perform(operand, context)
      context.instruction_pointer.should eq(4)
    end
  end
end

