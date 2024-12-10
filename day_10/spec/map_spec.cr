require "./spec_helper"

describe Map do
  describe ".from_input" do
    it "parses out all Point heights" do
      lines = [
        "0123",
        "1234",
        "8765",
        "9876",
      ]
      map = Map.from_input(lines)
      map.points[0].height.should eq(0)
      map.points[10].height.should eq(6)
      map.points[12].height.should eq(9)
      map.points[15].height.should eq(6)
    end
  end
end

