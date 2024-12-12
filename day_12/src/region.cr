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
    plots = Set(Plot).new

    considered_plots = Set(Plot).new
    plots_to_consider = [start_plot]
    while plots_to_consider.any?
      plot = plots_to_consider.shift
      considered_plots << plot
      next unless plot.plant_type == start_plot.plant_type

      plots << plot
      plots_to_consider += (plot.neighbors - considered_plots.to_a)
    end

    new(plots)
  end
end

