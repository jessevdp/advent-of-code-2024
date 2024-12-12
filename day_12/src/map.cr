class Map
  @rows : Array(Array(Plot))

  def initialize(@rows)
    @rows.each_with_index do |row, y|
      row.each_with_index do |plot, x|
        plot.link_neighbor(plot(x: x, y: y - 1))
        plot.link_neighbor(plot(x: x - 1, y: y))
        plot.link_neighbor(plot(x: x + 1, y: y))
        plot.link_neighbor(plot(x: x, y: y + 1))
      end
    end
  end

  def self.from_input(lines : Array(String))
    rows = lines.map_with_index do |line, y|
      line.chars.map_with_index do |plant_type, x|
        Plot.new(plant_type, x, y)
      end
    end
    new(rows)
  end

  def regions
    regions = [] of Region

    plots_to_consider = plots
    while plots_to_consider.any?
      plot = plots_to_consider.shift
      region = Region.for(plot)
      regions << region
      plots_to_consider -= region.plots.to_a
    end

    regions
  end

  def plots
    @rows.flatten
  end

  def plot(x, y)
    return if x < 0 || x >= width
    return if y < 0 || y >= height

    @rows[y][x]
  end

  def plot!(x, y)
    plot(x, y).not_nil!
  end

  def width
    return 0 unless @rows.any?

    @rows.first.size
  end

  def height
    @rows.size
  end
end

