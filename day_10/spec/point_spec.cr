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

  describe "#trails" do
    context "when Point is a trailend" do
      it "returns a single Trail with self as the end" do
        point = Point.new(height: 9)
        trails = point.trails
        trails.size.should eq(1)
        trails.first.end.should be(point)
      end
    end

    it "returns all possible Trails from Point" do
      # Map
      # ---
      # .....0.
      # ..4321.
      # ..5..2.
      # ..6543.
      # ..7..4.
      # ..8765.
      # ..9....
      #
      # Trails
      # ---
      # .....0.   .....0.   .....0.
      # ..4321.   .....1.   .....1.
      # ..5....   .....2.   .....2.
      # ..6....   ..6543.   .....3.
      # ..7....   ..7....   .....4.
      # ..8....   ..8....   ..8765.
      # ..9....   ..9....   ..9....
      #
      map = Map.from_input([
        "0000000",
        "0043210",
        "0050020",
        "0065430",
        "0070040",
        "0087650",
        "0090000",
      ])
      point = map.point!(x: 5, y: 0)
      trailend = map.point(x: 2, y: 6)
      trails = point.trails

      trails.size.should eq(3)
      trails.each do |trail|
        trail.start.should eq(point)
        trail.end.should eq(trailend)
      end
    end
  end
end

