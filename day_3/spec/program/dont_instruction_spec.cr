require "../spec_helper"

describe Program::DoInstruction do
  describe "#execute" do
    it "sets #enabled? to false in Program::Context" do
      context = Program::Context.new(enabled: true)
      context.enabled?.should be_true
      Program::DontInstruction.new.execute(context)
      context.enabled?.should be_false

      context = Program::Context.new(enabled: false)
      context.enabled?.should be_false
      Program::DontInstruction.new.execute(context)
      context.enabled?.should be_false
    end

    it "returns 0" do
      context = Program::Context.new(enabled: true)
      Program::DontInstruction.new.execute(context).should eq(0)
    end
  end
end
