require "./spec_helper"

describe Map do
  describe ".from_input" do
    it "parses out all Point heights" do
      lines = [
        "0123",
        "1234",
        "8765",
        "9876",
      ]
      map = Map.from_input(lines)
      map.point!(x: 0, y: 0).height.should eq(0)
      map.point!(x: 3, y: 0).height.should eq(3)
      map.point!(x: 1, y: 1).height.should eq(2)
      map.point!(x: 2, y: 2).height.should eq(6)
      map.point!(x: 0, y: 3).height.should eq(9)
      map.point!(x: 3, y: 3).height.should eq(6)
    end

    it "links all Points to its neighbours" do
      lines = [
        "0123",
        "1234",
        "8765",
        "9876",
      ]
      map = Map.from_input(lines)
      map.point!(x: 0, y: 0).neighbours.should eq([
        map.point!(x: 1, y: 0),
        map.point!(x: 0, y: 1),
      ])
      map.point!(x: 2, y: 1).neighbours.should eq([
        map.point!(x: 2, y: 0),
        map.point!(x: 1, y: 1),
        map.point!(x: 3, y: 1),
        map.point!(x: 2, y: 2),
      ])
    end
  end

  describe "#trailheads" do
    it "returns all Points with height=0" do
      lines = [
        "89010123",
        "78121874",
        "87430965",
        "96549874",
        "45678903",
        "32019012",
        "01329801",
        "10456732",
      ]
      map = Map.from_input(lines)
      map.trailheads.should eq([
        map.point!(x: 2, y: 0),
        map.point!(x: 4, y: 0),
        map.point!(x: 4, y: 2),
        map.point!(x: 6, y: 4),
        map.point!(x: 2, y: 5),
        map.point!(x: 5, y: 5),
        map.point!(x: 0, y: 6),
        map.point!(x: 6, y: 6),
        map.point!(x: 1, y: 7),
      ])
    end
  end

  describe "#total_score" do
    it "returns the sum of the score (amount of reachable trailends) for each trailhead" do
      lines = [
        "89010123",
        "78121874",
        "87430965",
        "96549874",
        "45678903",
        "32019012",
        "01329801",
        "10456732",
      ]
      map = Map.from_input(lines)
      map.total_score.should eq(36)
    end
  end

  describe "#total_rating" do
    it "returns the sum of the rating (amount of Trails) for each trailhead" do
      lines = [
        "89010123",
        "78121874",
        "87430965",
        "96549874",
        "45678903",
        "32019012",
        "01329801",
        "10456732",
      ]
      map = Map.from_input(lines)
      map.total_rating.should eq(81)
    end
  end
end

