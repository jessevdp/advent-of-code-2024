require "./spec_helper"

describe LocationList do
  describe "#difference_to(other_list)" do
    it "calculates the smallest possible difference between the two lists" do
      list_1 = LocationList.new([
        3,
        4,
        2,
        1,
        3,
        3,
      ])
      list_2 = LocationList.new([
        4,
        3,
        5,
        3,
        9,
        3,
      ])

      list_1.difference_to(list_2).should eq(11)
    end
  end
end

