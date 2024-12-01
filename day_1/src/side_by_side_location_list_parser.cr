class SideBySideLocationListParser
  @lines : Array(String)

  def initialize(@lines)
  end

  def parse
    list_1 = LocationList.new
    list_2 = LocationList.new

    @lines.each do |line|
      values = line.split
      list_1 << values.shift.to_i
      list_2 << values.shift.to_i
    end

    { list_1, list_2 }
  end
end
