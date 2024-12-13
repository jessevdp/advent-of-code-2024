require "./spec_helper"

describe Region do
  describe "#sides" do
    it "returns the total amount of distinct sides" do
      map = Map.from_input([
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC",
      ])
      Region.for(map.plot!(x: 0, y: 0)).sides.should eq(4) # A
      Region.for(map.plot!(x: 0, y: 1)).sides.should eq(4) # B
      Region.for(map.plot!(x: 2, y: 1)).sides.should eq(8) # C
      Region.for(map.plot!(x: 3, y: 1)).sides.should eq(4) # D
      Region.for(map.plot!(x: 0, y: 3)).sides.should eq(4) # E
    end

    it "can handle complex Regions" do
      map = Map.from_input([
        "EEEEE",
        "EXXXX",
        "EEEEE",
        "EXXXX",
        "EEEEE",
      ])
      Region.for(map.plot!(x: 0, y: 0)).sides.should eq(12) # E
      Region.for(map.plot!(x: 1, y: 1)).sides.should eq(4) # X
      Region.for(map.plot!(x: 1, y: 3)).sides.should eq(4) # X
    end
  end

  describe "#perimeter" do
    it "returns the total length of all outer edges of a Region" do
      map = Map.from_input([
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC",
      ])
      Region.for(map.plot!(x: 0, y: 0)).perimeter.should eq(10) # A
      Region.for(map.plot!(x: 0, y: 1)).perimeter.should eq(8) # B
      Region.for(map.plot!(x: 2, y: 1)).perimeter.should eq(10) # C
      Region.for(map.plot!(x: 3, y: 1)).perimeter.should eq(4) # D
      Region.for(map.plot!(x: 0, y: 3)).perimeter.should eq(8) # E
    end

    it "can handle complex nested Regions" do
      map = Map.from_input([
        "OOOOO",
        "OXOXO",
        "OOOOO",
        "OXOXO",
        "OOOOO",
      ])
      Region.for(map.plot!(x: 0, y: 0)).perimeter.should eq(36)
      Region.for(map.plot!(x: 1, y: 1)).perimeter.should eq(4)
      Region.for(map.plot!(x: 3, y: 1)).perimeter.should eq(4)
      Region.for(map.plot!(x: 1, y: 3)).perimeter.should eq(4)
      Region.for(map.plot!(x: 3, y: 3)).perimeter.should eq(4)
    end
  end

  describe "#area" do
    it "return the amount of plots covered by this Region" do
      map = Map.from_input([
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC",
      ])
      start_plot = map.plot!(x: 0, y: 0)
      region = Region.for(start_plot)
      region.area.should eq(4)
    end
  end

  describe ".for" do
    it "creates a Region containing all adjecent Plots of the same :plant_type recursively" do
      map = Map.from_input([
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC",
      ])
      start_plot = map.plot!(x: 0, y: 0)

      region = Region.for(start_plot)

      region.plots.size.should eq(4)
      region.plots.should contain(start_plot)
      region.plots.should contain(map.plot!(x: 1, y: 0))
      region.plots.should contain(map.plot!(x: 2, y: 0))
      region.plots.should contain(map.plot!(x: 3, y: 0))
    end
  end
end

