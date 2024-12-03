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
    it "returns ignores the result of instructions after `don't()` and re-enables after `do()`" do
      program = Program.new([
        Program::MulInstruction.new(2, 4),
        Program::DontInstruction.new(),
        Program::MulInstruction.new(5, 5),
        Program::MulInstruction.new(11, 8),
        Program::DoInstruction.new(),
        Program::MulInstruction.new(8, 5),
      ] of Program::Instruction)

      program.execute.should eq(48)
    end
  end
end

