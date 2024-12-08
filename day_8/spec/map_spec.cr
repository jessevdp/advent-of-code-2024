require "./spec_helper"

describe Map do
  describe "antinode_locations" do
    it "returns the set of unique antinode locations within bounds of the map" do
      lines = [
        "............",
        "........0...",
        ".....0......",
        ".......0....",
        "....0.......",
        "......A.....",
        "............",
        "............",
        "........A...",
        ".........A..",
        "............",
        "............",
      ]
      map = MapParser.new(lines).parse
      map.antinode_locations.size.should eq(14)
    end
  end
end

