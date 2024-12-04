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
end
