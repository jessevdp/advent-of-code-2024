class ProgramParser
  def initialize(@lines : Array(String))
  end

  def parse
    contents = parse_contents
    registers = parse_registers
    Program.new(contents, registers)
  end

  private def parse_registers
    registers = {} of Char => Register
    register_lines.each do |line|
      match = line.match!(/\ARegister (?<name>[A-Z]): (?<value>\d+)\z/)
      name = match["name"].chars.first
      value = match["value"].to_i
      registers[name] = Register.new(value)
    end
    registers
  end

  private def register_lines
    @lines.take_while { |line| !line.blank? }
  end

  private def parse_contents
    line = contents_line

    return [] of Int128 unless line

    match = line.match!(/\AProgram: (?<contents>\d(,\d)+)\z/)
    match["contents"].split(',').map(&.to_i128)
  end

  private def contents_line
    @lines.last if @lines.any?
  end
end
