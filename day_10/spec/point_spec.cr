require "./spec_helper"

describe Point do
  describe "#reachable_neighbours" do
    it "returns all neighbours that are exactly 1 higher than self" do
      point = Point.new(height: 1)
      a = Point.new(height: 2)
      b = Point.new(height: 0)
      c = Point.new(height: 3)
      d = Point.new(height: 2)
      point.neighbours = [a, b, c, d]
      point.reachable_neighbours.should eq([a, d])
    end
  end

  describe "#reachable_trailends" do
    it "returns all trailend Points that are reachable through #reachable_neighbours recursively" do
      map = Map.from_input([
        "0123",
        "1234",
        "8765",
        "9876",
      ])
      trailend = map.point!(x: 0, y: 3)
      map.point!(x: 0, y: 0).reachable_trailends.should eq(Set{trailend})
      map.point!(x: 0, y: 2).reachable_trailends.should eq(Set{trailend})
      map.point!(x: 0, y: 3).reachable_trailends.should eq(Set{trailend})
    end
  end
end

