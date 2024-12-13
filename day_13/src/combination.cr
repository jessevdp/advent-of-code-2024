record Combination,
  current_point : Point,
  total_cost : Int32 do

  def +(action : Action)
    copy_with(
      current_point: current_point + action,
      total_cost: total_cost + action.cost,
    )
  end

  def estimated_total_cost_to(target : Point)
    total_cost + current_point.manhattan_distance(target)
  end
end
