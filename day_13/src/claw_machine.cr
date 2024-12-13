class ClawMachine
  ACTION_MAXIMUM = 100

  getter target : Point
  getter actions : Array(Action)

  def initialize(@target, @actions)
  end

  def possible?
    max = Point.new(0, 0)
    @actions.each do |action|
      ACTION_MAXIMUM.times do
        max += action
      end
    end

    (max.x >= target.x) && (max.y >= target.y)
  end

  def cheapest_combination
    queue = PriorityQueue(Combination).new do |combination|
      combination.estimated_total_cost_to(target)
    end

    queue << Combination.new(
      current_point: Point.new(0, 0),
      total_cost: 0,
    )

    visited = Set(Point).new
    while queue.any?
      combination = queue.shift

      next if combination.current_point.in?(visited)
      visited << combination.current_point

      return combination if combination.current_point == target

      actions.each do |action|
        new_combination = combination + action
        next if (new_combination.current_point.x > target.x) || (new_combination.current_point.y > target.y)
        queue << new_combination
      end
    end
  end
end

