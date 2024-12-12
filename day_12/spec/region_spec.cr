require "./spec_helper"

describe Region do
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

