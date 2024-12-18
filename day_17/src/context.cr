class Context
  getter registers : Hash(Char, Register)
  getter output : Array(Int128)
  property instruction_pointer : Int128

  def initialize(
    @registers = {} of Char => Register,
    @instruction_pointer = 0,
    @output = [] of Int128)
  end
end

