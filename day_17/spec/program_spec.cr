require "./spec_helper"

describe Program do
  it "works with an example program" do
    program = Program.new(
      contents: [0, 1, 5, 4, 3, 0].map(&.to_i128),
      registers: {
        'A' => Register.new(729),
        'B' => Register.new(0),
        'C' => Register.new(0),
      },
    )
    program.run
    program.output.should eq("4,6,3,5,6,3,5,2,1,0")
  end
end

