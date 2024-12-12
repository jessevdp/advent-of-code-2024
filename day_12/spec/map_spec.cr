require "./spec_helper"

describe Map do
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
  end
end

