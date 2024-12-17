require "./spec_helper"
require "./test_operand"

describe BxcInstruction do
  it "writes the result of B^C into B" do
    context = Context.new(
      registers: {
        'B' => Register.new(6),
        'C' => Register.new(4),
      }
    )
    operand = TestOperand.of_value(value: 1)
    BxcInstruction.new.perform(operand, context)
    context.registers['B'].value.should eq(2)
  end
end

