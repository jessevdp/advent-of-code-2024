require "./spec_helper"

describe Robot do
  describe ".from_input" do
    it "parses out the :position and :velocity" do
      line = "p=0,4 v=1,3"
      bounds = BoundingBox.of_dimensions(width: 101, height: 103)
      robot = Robot.from_input(line, bounds)
      robot.position.should eq(Point.new(x: 0, y: 4))
      robot.velocity.should eq(Vector2d.new(dx: 1, dy: 3))
    end

    it "can parse out negative values for :velocity" do
      line = "p=0,4 v=-1,-3"
      bounds = BoundingBox.of_dimensions(width: 101, height: 103)
      robot = Robot.from_input(line, bounds)
      robot.velocity.should eq(Vector2d.new(dx: -1, dy: -3))
    end

    it "can parse out double digits for :position and :velocity" do
      line = "p=12,44 v=-11,23"
      bounds = BoundingBox.of_dimensions(width: 101, height: 103)
      robot = Robot.from_input(line, bounds)
      robot.position.should eq(Point.new(x: 12, y: 44))
      robot.velocity.should eq(Vector2d.new(dx: -11, dy: 23))
    end

    it "correctly forwards the :bounds" do
      line = "p=0,4 v=1,3"
      bounds = BoundingBox.of_dimensions(width: 101, height: 103)
      robot = Robot.from_input(line, bounds)
      robot.bounds.should eq(bounds)
    end
  end
end

