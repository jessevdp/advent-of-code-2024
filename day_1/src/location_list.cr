class LocationList
  include Indexable::Mutable(Int32)
  include Comparable(Array(Int32))

  def initialize(@location_ids = [] of Int32)
  end

  def difference_to(other_list : LocationList)
    total_difference = 0
    self.sort.zip(other_list.sort) do |value_1, value_2|
      difference = (value_1 - value_2).abs
      total_difference += difference
    end
    total_difference
  end

  def size
    @location_ids.size
  end

  def unsafe_fetch(index)
    @location_ids.unsafe_fetch(index)
  end

  def unsafe_put(index, value)
    @location_ids.unsafe_put(index, value)
  end

  def sort
    dup.sort!
  end

  def <<(location_id)
    @location_ids << location_id
  end

  def <=>(other : Array(Int32))
    @location_ids <=> other
  end
end
