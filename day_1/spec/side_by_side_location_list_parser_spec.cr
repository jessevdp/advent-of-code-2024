require "./spec_helper"

describe SideBySideLocationListParser do
  it "splits the lines into two lists" do
    input = [
      "3   4",
      "4   3",
      "2   5",
    ]
    list_1, list_2 = SideBySideLocationListParser.new(input).parse
    list_1.should eq([
      3,
      4,
      2,
    ])
    list_2.should eq([
      4,
      3,
      5,
    ])
  end
end
