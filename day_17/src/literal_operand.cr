class LiteralOperand < Operand
  def value : Int128
    @raw_operand
  end
end
