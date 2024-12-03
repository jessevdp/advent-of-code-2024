class ProgramParser
  def initialize(@lines = [] of String)
    @rules = [
      ProgramParser::Rule.create(/mul\((?<a>\d+),(?<b>\d+)\)/) do |match|
        a = match["a"].to_i
        b = match["b"].to_i
        Program::MulInstruction.new(a, b)
      end
    ]
  end

  def parse
    instructions = [] of Program::Instruction

    @lines.each do |line|
      @rules.each do |rule|
        matches = line.scan(rule.regex)
        matches.each do |match|
          instructions << rule.block.call(match)
        end
      end
    end

    Program.new(instructions)
  end
end

class ProgramParser::Rule
  getter regex, block
  def initialize(@regex : Regex, @block : Regex::MatchData -> Program::Instruction)
  end

  def self.create(regex : Regex, &block : Regex::MatchData -> Program::Instruction)
    new(regex, block)
  end
end
