require "./spec_helper"

describe ComboOperand do
  describe "#value" do
    context "when :raw_operand == 0, 1, 2, or 3" do
      it "returns the literal operand" do
        context = Context.new
        ComboOperand.new(0, context).value.should eq(0)
        ComboOperand.new(1, context).value.should eq(1)
        ComboOperand.new(2, context).value.should eq(2)
        ComboOperand.new(3, context).value.should eq(3)
      end
    end

    context "when :raw_operand == 4" do
      it "returns the value of the A register" do
        context = Context.new(registers: { 'A' => Register.new(12) })
        ComboOperand.new(4, context).value.should eq(12)
      end
    end

    context "when :raw_operand == 5" do
      it "returns the value of the B register" do
        context = Context.new(registers: { 'B' => Register.new(41) })
        ComboOperand.new(5, context).value.should eq(41)
      end
    end

    context "when :raw_operand == 6" do
      it "returns the value of the C register" do
        context = Context.new(registers: { 'C' => Register.new(33) })
        ComboOperand.new(6, context).value.should eq(33)
      end
    end
  end
end

