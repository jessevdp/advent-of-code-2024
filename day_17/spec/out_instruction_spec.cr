require "./spec_helper"
require "./test_operand"

describe OutInstruction do
  it "appends the result of <operand> % 8 to output" do
    context = Context.new(
      output: [1, 1, 9].map(&.to_i128)
    )
    operand = TestOperand.of_value(value: 12)
    OutInstruction.new.perform(operand, context)
    context.output.should eq([1, 1, 9, 4])
  end
end

