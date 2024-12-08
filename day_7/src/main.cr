class Equation
  getter result : Int64
  @numbers : Array(ConstantExpression)

  def initialize(@result, numbers)
    @numbers = numbers.map { |n| ConstantExpression.new(n) }
  end

  def possible?
    {{Operation.all_subclasses}}.each_repeated_permutation(@numbers.size - 1) do |operations|
      numbers = @numbers.each
      expression = numbers.next.as(Expression)
      operations.each do |operation|
        expression = operation.new(expression, numbers.next.as(Expression))
      end
      return true if expression.result == @result
    end

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

class ConcationationOperation < Operation
  def result : Int64
    a = @a.result
    b = @b.result
    digits_in_b = Math.log10(b.abs).ceil.to_i

    (a * (10 ** digits_in_b)) + b
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

puts "Part 2:"
puts equations.select(&.possible?).sum(&.result)

