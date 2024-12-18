abstract class Operand
  def initialize(@raw_operand : Int128, @context : Context)
  end

  abstract def value : Int128
end

