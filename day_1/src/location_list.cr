class LocationList
  alias LocationID = Int32

  getter location_ids : Array(LocationID)

  def initialize(@location_ids)
  end

  def difference_to(other_list : LocationList)
    total_difference = 0
    location_ids.sort.zip(other_list.location_ids.sort) do |value_1, value_2|
      difference = (value_1 - value_2).abs
      total_difference += difference
    end
    total_difference
  end
end
