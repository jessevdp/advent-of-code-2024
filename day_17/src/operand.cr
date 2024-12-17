abstract class Operand
  def initialize(@raw_operand : Int32, @context : Context)
  end

  abstract def value : Int32
end

