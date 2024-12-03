require "./spec_helper"

describe ProgramParser do
  it "parses out all valid `mul(a,b)` instructions across multiple lines" do
    lines = [
      "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
      "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
    ]
    program = ProgramParser.new(lines).parse
    program.instructions.should eq([
      Program::MulInstruction.new(2, 4),
      Program::MulInstruction.new(5, 5),
      Program::MulInstruction.new(11, 8),
      Program::MulInstruction.new(8, 5),
      Program::MulInstruction.new(2, 4),
      Program::MulInstruction.new(5, 5),
      Program::MulInstruction.new(11, 8),
      Program::MulInstruction.new(8, 5),
    ])
  end
end

