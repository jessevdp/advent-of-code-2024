class Context
  getter registers : Hash(Char, Register)
  getter output : Array(Int32)
  property instruction_pointer : Int32

  def initialize(
    @registers = {} of Char => Register,
    @instruction_pointer = 0,
    @output = [] of Int32)
  end
end

