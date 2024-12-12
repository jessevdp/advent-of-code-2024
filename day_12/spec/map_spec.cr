require "./spec_helper"

describe Map do
  describe "#regions" do
    it "returns all distinct Regions (of adjacent :plat_type)" do
      map = Map.from_input([
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC",
      ])
      regions = map.regions
      regions.size.should eq(5)
      regions.should contain(Region.new([
        map.plot!(x: 0, y: 0),
        map.plot!(x: 1, y: 0),
        map.plot!(x: 2, y: 0),
        map.plot!(x: 3, y: 0),
      ].to_set))
      regions.should contain(Region.new([
        map.plot!(x: 0, y: 1),
        map.plot!(x: 1, y: 1),
        map.plot!(x: 0, y: 2),
        map.plot!(x: 1, y: 2),
      ].to_set))
      regions.should contain(Region.new([
        map.plot!(x: 2, y: 1),
        map.plot!(x: 2, y: 2),
        map.plot!(x: 3, y: 2),
        map.plot!(x: 3, y: 3),
      ].to_set))
      regions.should contain(Region.new([
        map.plot!(x: 3, y: 1),
      ].to_set))
      regions.should contain(Region.new([
        map.plot!(x: 0, y: 3),
        map.plot!(x: 1, y: 3),
        map.plot!(x: 2, y: 3),
      ].to_set))
    end

    it "can handle complex nested Regions & multiple Regions of the same :plant_type" do
      map = Map.from_input([
        "OOOOO",
        "OXOXO",
        "OOOOO",
        "OXOXO",
        "OOOOO",
      ])
      regions = map.regions
      regions.size.should eq(5)
      regions.should contain(Region.new([
        map.plot!(x: 1, y: 1),
      ].to_set))
      regions.should contain(Region.new([
        map.plot!(x: 3, y: 1),
      ].to_set))
      regions.should contain(Region.new([
        map.plot!(x: 1, y: 3),
      ].to_set))
      regions.should contain(Region.new([
        map.plot!(x: 3, y: 3),
      ].to_set))
      regions.should contain(Region.new([
        map.plot!(x: 0, y: 0),
        map.plot!(x: 1, y: 0),
        map.plot!(x: 2, y: 0),
        map.plot!(x: 3, y: 0),
        map.plot!(x: 4, y: 0),
        map.plot!(x: 0, y: 1),
        map.plot!(x: 2, y: 1),
        map.plot!(x: 4, y: 1),
        map.plot!(x: 0, y: 2),
        map.plot!(x: 1, y: 2),
        map.plot!(x: 2, y: 2),
        map.plot!(x: 3, y: 2),
        map.plot!(x: 4, y: 2),
        map.plot!(x: 0, y: 3),
        map.plot!(x: 2, y: 3),
        map.plot!(x: 4, y: 3),
        map.plot!(x: 0, y: 4),
        map.plot!(x: 1, y: 4),
        map.plot!(x: 2, y: 4),
        map.plot!(x: 3, y: 4),
        map.plot!(x: 4, y: 4),
      ].to_set))
    end
  end

  describe ".from_input" do
    it "parses out all Plots including their :plant_type" do
      lines = [
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC",
      ]
      map = Map.from_input(lines)
      map.plot!(x: 0, y: 0).plant_type.should eq('A')
      map.plot!(x: 3, y: 0).plant_type.should eq('A')
      map.plot!(x: 0, y: 1).plant_type.should eq('B')
      map.plot!(x: 2, y: 2).plant_type.should eq('C')
      map.plot!(x: 3, y: 3).plant_type.should eq('C')
    end

    it "links all Plots to their neighbors" do
      lines = [
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC",
      ]
      map = Map.from_input(lines)
      map.plot!(x: 0, y: 0).neighbors.should eq([
        map.plot!(x: 1, y: 0),
        map.plot!(x: 0, y: 1),
      ])
      map.plot!(x: 2, y: 1).neighbors.should eq([
        map.plot!(x: 2, y: 0),
        map.plot!(x: 1, y: 1),
        map.plot!(x: 3, y: 1),
        map.plot!(x: 2, y: 2),
      ])
      map.plot!(x: 3, y: 3).neighbors.should eq([
        map.plot!(x: 3, y: 2),
        map.plot!(x: 2, y: 3),
      ])
    end

    it "sets the :x & :y coordinates of all Plots" do
      map = Map.from_input([
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC",
      ])

      map.plot!(x: 0, y: 0).x.should eq(0)
      map.plot!(x: 0, y: 0).y.should eq(0)

      map.plot!(x: 3, y: 0).x.should eq(3)
      map.plot!(x: 3, y: 0).y.should eq(0)

      map.plot!(x: 0, y: 1).x.should eq(0)
      map.plot!(x: 0, y: 1).y.should eq(1)

      map.plot!(x: 2, y: 2).x.should eq(2)
      map.plot!(x: 2, y: 2).y.should eq(2)

      map.plot!(x: 3, y: 3).x.should eq(3)
      map.plot!(x: 3, y: 3).y.should eq(3)
    end
  end
end

