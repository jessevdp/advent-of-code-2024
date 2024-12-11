record Stone, value : Int32

abstract class EvolutionRule
  abstract def applies_to?(stone : Stone) : Bool
  abstract def apply_to(stone : Stone) : Array(Stone)
end

class ZeroToOneEvolution < EvolutionRule
  def applies_to?(stone : Stone) : Bool
    stone.value == 0
  end

  def apply_to(stone : Stone) : Array(Stone)
    [Stone.new(value: 1)]
  end
end

class SplitEvenDigitsEvolution < EvolutionRule
  def applies_to?(stone : Stone) : Bool
    digit_count(stone).even?
  end

  def apply_to(stone : Stone) : Array(Stone)
    digit_count = digit_count(stone)
    divisor = 10 ** (digit_count // 2)
    right = stone.value // divisor
    left = stone.value % divisor

    [
      Stone.new(value: right),
      Stone.new(value: left),
    ]
  end

  private def digit_count(stone)
    Math.log10(stone.value).floor.to_i + 1
  end
end

class AlwaysMultiplyEvolution < EvolutionRule
  def initialize(@factor : Int32)
  end

  def applies_to?(stone : Stone) : Bool
    true
  end

  def apply_to(stone : Stone) : Array(Stone)
    [Stone.new(value: stone.value * @factor)]
  end
end

