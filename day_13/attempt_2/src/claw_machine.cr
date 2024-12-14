class ClawMachine
  property target : Point
  getter actions : Array(Action)

  def initialize(@target, @actions)
  end

  def possible_with_budget?(presses_per_action)
    max = Point.new(0, 0)
    @actions.each do |action|
      presses_per_action.times do
        max += action
      end
    end

    (max.x >= target.x) && (max.y >= target.y)
  end

  def cheapest_combination
    Combination.new(total_cost: 0)
  end
end

