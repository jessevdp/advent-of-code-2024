class CharacterGrid
  @rows : Array(Array(CharacterGrid::Cell))

  def initialize(lines)
    @rows = lines.map do |line|
      line.chars.map { |char| CharacterGrid::Cell.new(char) }
    end
  end

  def cell_at(x, y)
    return if x < 0 || x >= width
    return if y < 0 || y >= height

    @rows[y][x]
  end

  def width
    return 0 unless @rows.any?

    @rows.first.size
  end

  def height
    @rows.size
  end
end

class CharacterGrid::Cell
  getter content : Char

  def initialize(@content)
  end
end
