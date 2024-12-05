class CharacterGrid
  @rows : Array(Array(CharacterGrid::Cell))

  def initialize(lines)
    @rows = lines.map do |line|
      line.chars.map { |char| CharacterGrid::Cell.new(char) }
    end
  end

  def cell_at(x, y)
    cell_at(CharacterGrid::Coordinate.new(x, y))
  end

  def cell_at(coordinate)
    return unless contains?(coordinate)

    @rows[coordinate.y][coordinate.x]
  end

  def contains?(coordinate)
    return false if coordinate.x < 0 || coordinate.x >= width
    return false if coordinate.y < 0 || coordinate.y >= height
    true
  end

  def width
    return 0 unless @rows.any?

    @rows.first.size
  end

  def height
    @rows.size
  end
end

class CharacterGrid::Coordinate
  getter x : Int32
  getter y : Int32
  def initialize(@x, @y)
  end
end

class CharacterGrid::Cell
  getter content : Char

  def initialize(@content)
  end
end
