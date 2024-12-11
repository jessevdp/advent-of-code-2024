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

