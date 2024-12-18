require "./spec_helper"

describe ProgramParser do
  it "parses out registers A,B,C and program contents" do
    lines = [
      "Register A: 729",
      "Register B: 0",
      "Register C: 0",
      "",
      "Program: 0,1,5,4,3,0",
    ]
    program = ProgramParser.new(lines).parse
    program.contents.should eq([0, 1, 5, 4, 3, 0])
    program.context.registers['A'].value.should eq(729)
    program.context.registers['B'].value.should eq(0)
    program.context.registers['C'].value.should eq(0)
  end
end
