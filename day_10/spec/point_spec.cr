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
end

