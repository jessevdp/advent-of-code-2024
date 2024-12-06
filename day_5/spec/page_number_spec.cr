require "./spec_helper"

describe PageNumber do
  describe "#in_correct_spot?" do
    it "returns true when in compliance with all relevant ordering rules" do
      previous = [
        PageNumber.new(75, [] of OrderingRule),
        PageNumber.new(47, [] of OrderingRule),
      ]
      upcoming = [
        PageNumber.new(53, [] of OrderingRule),
        PageNumber.new(29, [] of OrderingRule),
      ]
      current = PageNumber.new(61, [
        OrderingRule.new(97, 61),
        OrderingRule.new(61, 13),
        OrderingRule.new(61, 53),
        OrderingRule.new(61, 29),
        OrderingRule.new(47, 61),
        OrderingRule.new(75, 61),
      ])
      current.in_correct_spot?(previous, upcoming).should be_true
    end

    it "returns false when NOT in compliance with all relevant ordering rules" do
      previous = [
        PageNumber.new(75, [] of OrderingRule),
      ]
      upcoming = [
        PageNumber.new(47, [] of OrderingRule),
        PageNumber.new(61, [] of OrderingRule),
        PageNumber.new(53, [] of OrderingRule),
      ]
      current = PageNumber.new(97, [
        OrderingRule.new(97, 13),
        OrderingRule.new(97, 61),
        OrderingRule.new(97, 47),
        OrderingRule.new(97, 29),
        OrderingRule.new(97, 53),
        OrderingRule.new(97, 75),
      ])
      current.in_correct_spot?(previous, upcoming).should be_false
    end
  end
end
