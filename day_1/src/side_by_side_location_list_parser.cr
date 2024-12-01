class SideBySideLocationListParser
  @lines : Array(String)

  def initialize(@lines)
  end

  def parse
    column_1 = [] of LocationList::LocationID
    column_2 = [] of LocationList::LocationID
    @lines.each do |line|
      values = line.split
      column_1 << values.shift.to_i
      column_2 << values.shift.to_i
    end

    {
      LocationList.new(column_1),
      LocationList.new(column_2)
    }
  end
end
