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
    rows = lines.map do |line|
      line.chars.map { |plant_type| Plot.new(plant_type) }
    end
    new(rows)
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

