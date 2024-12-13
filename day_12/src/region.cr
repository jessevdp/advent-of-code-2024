record Region, plots : Set(Plot) do
  def area
    plots.size
  end

  def perimeter
    total = 0

    plots.each do |plot|
      neighbors_in_region = plot.neighbors & plots.to_a
      total += Plot::SIDES - neighbors_in_region.size
    end

    total
  end

  def sides
    outer_edges = plots.map(&.edges).flatten.reject do |edge|
      plot_in_direction?(edge.x, edge.y, edge.direction)
    end

    grouped_edges = outer_edges
      .group_by(&.direction)
      .transform_values do |edges, direction|
        edges.group_by do |edge|
          edge.axis_value(direction.axis)
        end.values
      end

    total_sides = 0

    grouped_edges.each do |direction, groups|
      groups.each do |edges|
        total_sides += 1
        coordinates_1d = edges.map { |edge| edge.axis_value(direction.axis.opposite) }
        coordinates_1d.sort!
        coordinates_1d.each_cons_pair do |a, b|
          total_sides += 1 if (b - a) > 1
        end
      end
    end

    total_sides
  end

  private def plot_in_direction?(x, y, direction : Direction)
    x = x + direction.delta_x
    y = y + direction.delta_y
    plots.any? do |plot|
      (plot.x == x) && (plot.y == y)
    end
  end

  def self.for(start_plot : Plot)
    plots = [start_plot]

    head = 0
    while head < plots.size
      plot = plots[head]
      head += 1
      plots += plot.neighbors
        .select { |neighbor| neighbor.plant_type == plot.plant_type }
        .reject { |neighbor| plots.includes?(neighbor) }
    end

    new(plots.to_set)
  end
end

