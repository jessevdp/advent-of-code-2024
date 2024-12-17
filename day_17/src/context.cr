class Context
  getter registers : Hash(Char, Register)
  property instruction_pointer : Int32

  def initialize(@registers, @instruction_pointer = 0)
  end
end

