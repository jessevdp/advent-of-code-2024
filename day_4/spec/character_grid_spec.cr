require "./spec_helper"

describe CharacterGrid do
  it "contains all characters" do
    grid = CharacterGrid.new([
      "ABC",
      "DEF",
      "GHI",
    ])
    grid.cell_at(x: 0, y: 0).not_nil!.content.should eq('A')
    grid.cell_at(x: 1, y: 0).not_nil!.content.should eq('B')
    grid.cell_at(x: 2, y: 0).not_nil!.content.should eq('C')
    grid.cell_at(x: 0, y: 1).not_nil!.content.should eq('D')
    grid.cell_at(x: 1, y: 1).not_nil!.content.should eq('E')
    grid.cell_at(x: 2, y: 1).not_nil!.content.should eq('F')
    grid.cell_at(x: 0, y: 2).not_nil!.content.should eq('G')
    grid.cell_at(x: 1, y: 2).not_nil!.content.should eq('H')
    grid.cell_at(x: 2, y: 2).not_nil!.content.should eq('I')
  end

  describe "#value_at" do
    it "returns the string of :length in :direction starting at :coordinate" do
      grid = CharacterGrid.new([
        "ABC",
        "DEF",
        "GHI",
      ])
      grid.value_at(x: 0, y: 0, length: 3, direction: :right).should eq("ABC")
      grid.value_at(x: 0, y: 0, length: 3, direction: :down_right).should eq("AEI")
      grid.value_at(x: 1, y: 1, length: 2, direction: :down_right).should eq("EI")
    end

    it "returns nil when a string of :length in :direction is not possible at :coordinate" do
      grid = CharacterGrid.new([
        "ABC",
        "DEF",
        "GHI",
      ])
      grid.value_at(x: 0, y: 0, length: 4, direction: :right).should be_nil
      grid.value_at(x: 1, y: 1, length: 3, direction: :down).should be_nil
    end
  end
end

describe CharacterGrid::Cell do
  describe "value_in_direction" do
    it "returns the string of :length in :direction" do
      grid = CharacterGrid.new([
        "ABC",
        "DEF",
        "GHI",
      ])
      grid.cell_at(x: 0, y: 0).not_nil!
        .value_in_direction(direction: :right, length: 3).should eq("ABC")
      grid.cell_at(x: 0, y: 0).not_nil!
        .value_in_direction(direction: :down_right, length: 3).should eq("AEI")
      grid.cell_at(x: 1, y: 1).not_nil!
        .value_in_direction(direction: :down_right, length: 2).should eq("EI")
    end

    it "returns nil when a string of :length in :direction is not possible" do
      grid = CharacterGrid.new([
        "ABC",
        "DEF",
        "GHI",
      ])

      grid.cell_at(x: 0, y: 0).not_nil!
        .value_in_direction(direction: :right, length: 4).should be_nil
      grid.cell_at(x: 1, y: 1).not_nil!
        .value_in_direction(direction: :down, length: 3).should be_nil
    end

    it "can handle an offset" do
      grid = CharacterGrid.new([
        "ABC",
        "DEF",
        "GHI",
      ])
      grid.cell_at(x: 1, y: 1).not_nil!
        .value_in_direction(:down_right, length: 3, offset: -1).should eq("AEI")
      grid.cell_at(x: 1, y: 1).not_nil!
        .value_in_direction(:down_right, length: 3, offset: -2).should be_nil
    end
  end
end

