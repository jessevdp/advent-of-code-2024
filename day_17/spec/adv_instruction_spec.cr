require "./spec_helper"
require "./test_operand"

describe AdvInstruction do
  it "writes the result of A/(2^<operand>) into A" do
    context = Context.new(
      registers: {
        'A' => Register.new(32),
      }
    )
    operand = TestOperand.of_value(value: 2)
    AdvInstruction.new.perform(operand, context)
    context.registers['A'].value.should eq(8)
  end
end

