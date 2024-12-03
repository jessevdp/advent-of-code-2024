require "./spec_helper"

describe Program do
  describe "#execute" do
    it "returns the sum of the results of all instructions" do
      program = Program.new([
        Program::MulInstruction.new(2, 4),
        Program::MulInstruction.new(5, 5),
        Program::MulInstruction.new(11, 8),
        Program::MulInstruction.new(8, 5),
      ] of Program::Instruction)

      program.execute.should eq(161)
    end
  end
end

