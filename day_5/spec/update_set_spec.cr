require "./spec_helper"

ordering_rules = [
  OrderingRule.new(47, 53),
  OrderingRule.new(97, 13),
  OrderingRule.new(97, 61),
  OrderingRule.new(97, 47),
  OrderingRule.new(75, 29),
  OrderingRule.new(61, 13),
  OrderingRule.new(75, 53),
  OrderingRule.new(29, 13),
  OrderingRule.new(97, 29),
  OrderingRule.new(53, 29),
  OrderingRule.new(61, 53),
  OrderingRule.new(97, 53),
  OrderingRule.new(61, 29),
  OrderingRule.new(47, 13),
  OrderingRule.new(75, 47),
  OrderingRule.new(97, 75),
  OrderingRule.new(47, 61),
  OrderingRule.new(75, 61),
  OrderingRule.new(47, 29),
  OrderingRule.new(75, 13),
  OrderingRule.new(53, 13),
]

describe UpdateSet do
  describe "#correctly_ordered?" do
    it "returns true when all page numbers are ordered in compliance with the ordering rules" do
      UpdateSet.build([75, 47, 61, 53, 29], ordering_rules).correctly_ordered?.should be_true
      UpdateSet.build([97, 61, 53, 29, 13], ordering_rules).correctly_ordered?.should be_true
      UpdateSet.build([75, 29, 13], ordering_rules).correctly_ordered?.should be_true
    end

    it "returns true when all page numbers are ordered in compliance with the ordering rules" do
      UpdateSet.build([75, 97, 47, 61, 53], ordering_rules).correctly_ordered?.should be_false
      UpdateSet.build([61, 13, 29], ordering_rules).correctly_ordered?.should be_false
      UpdateSet.build([97, 13, 75, 29, 47], ordering_rules).correctly_ordered?.should be_false
    end
  end

  describe "#middle_page_number" do
    it "works" do
      UpdateSet.build([75, 47, 61, 53, 29], ordering_rules).middle_page_number.value.should eq(61)
      UpdateSet.build([97, 61, 53, 29, 13], ordering_rules).middle_page_number.value.should eq(53)
      UpdateSet.build([75, 29, 13], ordering_rules).middle_page_number.value.should eq(29)
    end
  end
end
