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
      map.point!(x: 0, y: 0).height.should eq(0)
      map.point!(x: 3, y: 0).height.should eq(3)
      map.point!(x: 1, y: 1).height.should eq(2)
      map.point!(x: 2, y: 2).height.should eq(6)
      map.point!(x: 0, y: 3).height.should eq(9)
      map.point!(x: 3, y: 3).height.should eq(6)
    end

    it "links all Points to its neighbours" do
      lines = [
        "0123",
        "1234",
        "8765",
        "9876",
      ]
      map = Map.from_input(lines)
      map.point!(x: 0, y: 0).neighbours.should eq([
        map.point!(x: 1, y: 0),
        map.point!(x: 0, y: 1),
      ])
      map.point!(x: 2, y: 1).neighbours.should eq([
        map.point!(x: 2, y: 0),
        map.point!(x: 1, y: 1),
        map.point!(x: 3, y: 1),
        map.point!(x: 2, y: 2),
      ])
    end
  end
end

