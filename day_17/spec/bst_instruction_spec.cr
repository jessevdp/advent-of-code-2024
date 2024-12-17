require "./spec_helper"
require "./test_operand"

describe BstInstruction do
  it "writes the result of <operand> % 8 into B" do
    context = Context.new(
      registers: {
        'B' => Register.new(0),
      }
    )
    operand = TestOperand.new(value: 12)
    BstInstruction.new.perform(operand, context)
    context.registers['B'].value.should eq(4)
  end
end

