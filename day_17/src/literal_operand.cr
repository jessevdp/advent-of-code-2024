class LiteralOperand < Operand
  def value : Int32
    @raw_operand
  end
end
