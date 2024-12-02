require "./spec_helper"

describe Report do
  describe "#safe?" do
    it "returns true when levels are only decreasing by 1, 2, or 3" do
      report = Report.new([7, 6, 4, 2, 1])
      report.safe?.should be_true
    end

    it "returns flase when there is an increase > 3" do
      report = Report.new([1, 2, 7, 8, 9])
      report.safe?.should be_false
    end

    it "returns flase when there is a decrease > 3" do
      report = Report.new([9, 7, 6, 2, 1])
      report.safe?.should be_false
    end

    it "returns false when some levels increase while others decrease" do
      report = Report.new([1, 3, 2, 4, 5])
      report.safe?.should be_false
    end

    it "returns false when some levels stay the same" do
      report = Report.new([8, 6, 4, 4, 1])
      report.safe?.should be_false
    end

    it "returns true when levels are only increasing by 1, 2, or 3" do
      report = Report.new([1, 3, 6, 7, 9])
      report.safe?.should be_true
    end
  end
end

