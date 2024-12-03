require "../spec_helper"

describe Program::MulInstruction do
  describe "#execute" do
    it "returns the result of multiplying a * b" do
      Program::MulInstruction.new(2, 4).execute.should eq(8)
      Program::MulInstruction.new(5, 5).execute.should eq(25)
      Program::MulInstruction.new(11, 8).execute.should eq(88)
      Program::MulInstruction.new(8, 5).execute.should eq(40)
    end
  end
end
