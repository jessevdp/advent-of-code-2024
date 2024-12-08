class Equation
  getter result : Int64
  @numbers : Array(ConstantExpression)

  def initialize(@result, numbers)
    @numbers = numbers.map { |n| ConstantExpression.new(n) }
  end

  def possible?
    false
  end
end

abstract class Expression
  abstract def result : Int64
end

class ConstantExpression < Expression
  def initialize(@value : Int64)
  end

  def result : Int64
    @value
  end
end

abstract class Operation < Expression
  getter a : Expression
  getter b : Expression

  def initialize(@a, @b)
  end
end

class AddOperation < Operation
  def result : Int64
    @a.result + @b.result
  end
end

class MultiplyOperation < Operation
  def result : Int64
    @a.result * @b.result
  end
end

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

equations = lines.map do |line|
  numbers = line.delete(':').split.map(&.to_i64)
  result = numbers.shift
  Equation.new(result, numbers)
end

puts "Part 1:"
puts equations.select(&.possible?).sum(&.result)
