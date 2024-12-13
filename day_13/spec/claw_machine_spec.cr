require "./spec_helper"

describe ClawMachine do
  describe "#cheapest_combination" do
    it "returns the total cost of the cheapest combination of actions that reaches the target" do
      ClawMachine.new(
        target: Point.new(x: 8400, y: 5400),
        actions: [
          Action.new(dx: 94, dy: 34, cost: 3),
          Action.new(dx: 22, dy: 67, cost: 1),
        ],
      ).cheapest_combination.not_nil!.total_cost.should eq(280)

      ClawMachine.new(
        target: Point.new(x: 7870, y: 6450),
        actions: [
          Action.new(dx: 17, dy: 86, cost: 3),
          Action.new(dx: 84, dy: 37, cost: 1),
        ],
      ).cheapest_combination.not_nil!.total_cost.should eq(200)
    end
  end

  describe "#possible?" do
    it "returns false if 100 of each action is not sufficient to even reach the target" do
      ClawMachine.new(
        target: Point.new(x: 12748, y: 12176),
        actions: [
          Action.new(dx: 26, dy: 66, cost: 3),
          Action.new(dx: 67, dy: 21, cost: 1),
        ],
      ).possible?.should be_false

      ClawMachine.new(
        target: Point.new(x: 18641, y: 10279),
        actions: [
          Action.new(dx: 69, dy: 23, cost: 3),
          Action.new(dx: 27, dy: 71, cost: 1),
        ],
      ).possible?.should be_false
    end

    it "returns true if the target is reachable" do
      ClawMachine.new(
        target: Point.new(x: 8400, y: 5400),
        actions: [
          Action.new(dx: 94, dy: 34, cost: 3),
          Action.new(dx: 22, dy: 67, cost: 1),
        ],
      ).possible?.should be_true

      ClawMachine.new(
        target: Point.new(x: 7870, y: 6450),
        actions: [
          Action.new(dx: 17, dy: 86, cost: 3),
          Action.new(dx: 84, dy: 37, cost: 1),
        ],
      ).possible?.should be_true
    end
  end
end
