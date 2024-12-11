require "./spec_helper"

describe ZeroToOneEvolution do
  it "applies when Stone#value == 0" do
    ZeroToOneEvolution.new.applies_to?(Stone.new(0)).should be_true
    ZeroToOneEvolution.new.applies_to?(Stone.new(1)).should be_false
    ZeroToOneEvolution.new.applies_to?(Stone.new(23)).should be_false
  end

  it "replaces the Stone with one where value=1" do
    result = ZeroToOneEvolution.new.apply_to(Stone.new(0))
    result.size.should eq(1)
    result.first.should eq(Stone.new(1))
  end
end

describe SplitEvenDigitsEvolution do
  it "applies when Stone#value has an even number of digits" do
    SplitEvenDigitsEvolution.new.applies_to?(Stone.new(10)).should be_true
    SplitEvenDigitsEvolution.new.applies_to?(Stone.new(23)).should be_true
    SplitEvenDigitsEvolution.new.applies_to?(Stone.new(1)).should be_false
    SplitEvenDigitsEvolution.new.applies_to?(Stone.new(53261)).should be_false
  end

  it "splits the Stone in the middle by digits" do
    result = SplitEvenDigitsEvolution.new.apply_to(Stone.new(21))
    result.size.should eq(2)
    result[0].should eq(Stone.new(2))
    result[1].should eq(Stone.new(1))
  end
end

