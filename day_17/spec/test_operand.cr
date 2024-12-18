class TestOperand < Operand
  def self.of_value(value)
    new(raw_operand: value, context: Context.new)
  end

  def value : Int128
    @raw_operand
  end
end

