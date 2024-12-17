class TestOperand < Operand
  def self.of_value(value)
    new(raw_operand: value, context: Context.new)
  end

  def value : Int32
    @raw_operand
  end
end

