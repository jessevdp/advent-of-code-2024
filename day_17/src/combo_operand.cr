class ComboOperand < Operand
  def value : Int32
    case @raw_operand
    when 0..3 then @raw_operand
    when 4 then @context.registers['A'].value
    when 5 then @context.registers['B'].value
    when 6 then @context.registers['C'].value
    else
      raise "invalid operand '#{@raw_operand}'"
    end
  end
end

