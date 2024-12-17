require "./spec_helper"
require "./test_operand"

describe CdvInstruction do
  it "writes the result of A/(2^<operand>) into C" do
    context = Context.new(
      registers: {
        'A' => Register.new(32),
        'C' => Register.new(0),
      }
    )
    operand = TestOperand.of_value(value: 2)
    CdvInstruction.new.perform(operand, context)
    context.registers['C'].value.should eq(8)
    context.registers['A'].value.should eq(32)
  end
end

