require "./spec_helper"
require "./test_operand"

describe BxlInstruction do
  it "writes the result of B^<operand> into B" do
    context = Context.new(
      registers: {
        'B' => Register.new(6),
      }
    )
    operand = TestOperand.new(value: 4)
    BxlInstruction.new.perform(operand, context)
    context.registers['B'].value.should eq(2)
  end
end

