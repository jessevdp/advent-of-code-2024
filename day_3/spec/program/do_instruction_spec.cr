require "../spec_helper"

describe Program::DoInstruction do
  describe "#execute" do
    it "sets #enabled? to true in Program::Context" do
      context = Program::Context.new(enabled: false)
      context.enabled?.should be_false
      Program::DoInstruction.new.execute(context)
      context.enabled?.should be_true

      context = Program::Context.new(enabled: true)
      context.enabled?.should be_true
      Program::DoInstruction.new.execute(context)
      context.enabled?.should be_true
    end

    it "returns 0" do
      context = Program::Context.new(enabled: false)
      Program::DoInstruction.new.execute(context).should eq(0)
    end
  end
end
