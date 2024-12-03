class ProgramParser
  def initialize(@lines = [] of String)
    @rules = [
      ProgramParser::Rule.create(/mul\((?<a>\d+),(?<b>\d+)\)/) do |match|
        a = match["a"].to_i
        b = match["b"].to_i
        Program::MulInstruction.new(a, b)
      end,
      ProgramParser::Rule.create(/do\(\)/) { Program::DoInstruction.new },
      ProgramParser::Rule.create(/don't\(\)/) { Program::DontInstruction.new },
    ]
  end

  def parse
    instructions = [] of Program::Instruction

    @lines.each do |line|
      matches = [] of ProgramParser::Match
      @rules.each do |rule|
        matches += rule.scan(line)
      end
      instructions += matches.sort_by(&.begin_position_in_line).map(&.instruction)
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

  def scan(line : String)
    matches = line.scan(@regex).map do |match|
      instruction = @block.call(match)
      ProgramParser::Match.new(instruction, match)
    end
  end
end

class ProgramParser::Match
  getter instruction

  def initialize(@instruction : Program::Instruction, @regex_match : Regex::MatchData)
  end

  def begin_position_in_line
    @regex_match.begin
  end
end
