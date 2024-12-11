require "./spec_helper"

describe Stone do
  describe "#evolve" do
    context "when value == 0" do
      it "evolves into a Stone with value=1" do
        evolution = Stone.new(0).evolve
        evolution.size.should eq(1)
        evolution.first.value.should eq(1)
      end
    end

    context "when value has an even number of digits" do
      it "evolves into 2 stones each with a value equal to one half of the digits" do
        evolution = Stone.new(10).evolve
        evolution.size.should eq(2)
        evolution[0].value.should eq(1)
        evolution[1].value.should eq(0)

        evolution = Stone.new(9923).evolve
        evolution.size.should eq(2)
        evolution[0].value.should eq(99)
        evolution[1].value.should eq(23)
      end
    end

    context "when no other rules apply" do
      it "evolves into a Stone by multiplying its value by 2024" do
        evolution = Stone.new(999).evolve
        evolution.size.should eq(1)
        evolution.first.value.should eq(2021976)
      end
    end
  end
end

