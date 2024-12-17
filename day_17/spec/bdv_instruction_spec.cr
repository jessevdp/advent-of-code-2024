require "./spec_helper"
require "./test_operand"

describe BdvInstruction do
  it "writes the result of A/(2^<operand>) into B" do
    context = Context.new(
      registers: {
        'A' => Register.new(32),
        'B' => Register.new(0),
      }
    )
    operand = TestOperand.of_value(value: 2)
    BdvInstruction.new.perform(operand, context)
    context.registers['B'].value.should eq(8)
    context.registers['A'].value.should eq(32)
  end
end

