class Plot
  SIDES = 4

  getter plant_type : Char
  getter neighbors : Array(Plot)

  getter x : Int32
  getter y : Int32

  def initialize(@plant_type, @x, @y)
    @neighbors = [] of Plot
  end

  def link_neighbor(plot)
    return unless plot
    raise "too many neighbors" if @neighbors.size >= SIDES

    @neighbors << plot
  end
end

