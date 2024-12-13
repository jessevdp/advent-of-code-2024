class ClawMachinesConfigurationParser
  def initialize(@input : Array(String))
  end

  def parse
    claw_machines = [] of ClawMachine

    @input.reject(&.blank?).each_slice(3) do |configuration|
      action_a_match = configuration[0].match!(/Button A: X\+(?<x>\d+), Y\+(?<y>\d+)/)
      action_a = Action.new(
        dx: action_a_match["x"].to_i,
        dy: action_a_match["y"].to_i,
        cost: 3,
      )

      action_b_match = configuration[1].match!(/Button B: X\+(?<x>\d+), Y\+(?<y>\d+)/)
      action_b = Action.new(
        dx: action_b_match["x"].to_i,
        dy: action_b_match["y"].to_i,
        cost: 1,
      )

      target_match = configuration[2].match!(/Prize: X=(?<x>\d+), Y=(?<y>\d+)/)
      target = Point.new(
        x: target_match["x"].to_i,
        y: target_match["y"].to_i,
      )

      claw_machines << ClawMachine.new(target, [action_a, action_b])
    end

    claw_machines
  end
end

