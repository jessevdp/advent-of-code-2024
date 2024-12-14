require "./spec_helper"

describe ClawMachinesConfigurationParser do
  it "parses out all ClawMachines including their Target & Actions" do
    input = [
      "Button A: X+94, Y+34",
      "Button B: X+22, Y+67",
      "Prize: X=8400, Y=5400",
      "",
      "Button A: X+26, Y+66",
      "Button B: X+67, Y+21",
      "Prize: X=12748, Y=12176",
      "",
      "Button A: X+17, Y+86",
      "Button B: X+84, Y+37",
      "Prize: X=7870, Y=6450",
      "",
      "Button A: X+69, Y+23",
      "Button B: X+27, Y+71",
      "Prize: X=18641, Y=10279",
    ]
    claw_machines = ClawMachinesConfigurationParser.new(input).parse
    claw_machines[0].target.should eq(Point.new(8400, 5400))
    claw_machines[0].actions.should eq([
      Action.new(dx: 94, dy: 34, cost: 3),
      Action.new(dx: 22, dy: 67, cost: 1),
    ])
    claw_machines[1].target.should eq(Point.new(12748, 12176))
    claw_machines[1].actions.should eq([
      Action.new(dx: 26, dy: 66, cost: 3),
      Action.new(dx: 67, dy: 21, cost: 1),
    ])
    claw_machines[2].target.should eq(Point.new(7870, 6450))
    claw_machines[2].actions.should eq([
      Action.new(dx: 17, dy: 86, cost: 3),
      Action.new(dx: 84, dy: 37, cost: 1),
    ])
    claw_machines[3].target.should eq(Point.new(18641, 10279))
    claw_machines[3].actions.should eq([
      Action.new(dx: 69, dy: 23, cost: 3),
      Action.new(dx: 27, dy: 71, cost: 1),
    ])
  end
end
