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

