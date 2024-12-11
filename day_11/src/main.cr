record Stone, value : Int64 do
  EVOLUTION_RULES = [
    ZeroToOneEvolution.new,
    SplitEvenDigitsEvolution.new,
  ]
  FALLBACK_EVOLUTION_RULE = AlwaysMultiplyEvolution.new(factor: 2024)

  def evolve(generations = 1, cache = EvolutionCache.new)
    return [self] if generations <= 0

    cached = cache.find(self, generations)

    if cached
      puts "cached generations=#{generations} #{value}"
      return cached
    end

    puts "miss generations=#{generations} #{value}"

    next_generation = evolution_rule.apply_to(self)
    result = next_generation.flat_map do |stone|
      stone.evolve(generations - 1, cache)
    end

    cache.add(self, generations, result)

    result
  end

  private def evolution_rule
    rule = EVOLUTION_RULES.find { |rule| rule.applies_to?(self) }
    rule || FALLBACK_EVOLUTION_RULE
  end
end

class EvolutionCache
  @known_evolutions = Hash(Tuple(Stone, Int32), Array(Stone)).new

  def add(original_stone, amount_of_generations, full_evolution)
    @known_evolutions[{ original_stone, amount_of_generations }] = full_evolution
  end

  def find(original_stone, amount_of_generations)
    @known_evolutions[{ original_stone, amount_of_generations }]?
  end
end

class StoneSet
  getter stones : Array(Stone)

  def initialize(@stones)
    @cache = EvolutionCache.new
  end

  def evolve(generations = 1)
    @stones = @stones.flat_map do |stone|
      stone.evolve(generations, @cache)
    end
  end
end

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
  def initialize(@factor : Int64)
  end

  def applies_to?(stone : Stone) : Bool
    true
  end

  def apply_to(stone : Stone) : Array(Stone)
    [Stone.new(value: stone.value * @factor)]
  end
end

line = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath).first
else
  ""
end

initial_stones = line.split
  .map(&.to_i)
  .map { |value| Stone.new(value) }

puts "Part 1:"
part_one_set = StoneSet.new(initial_stones)
part_one_set.evolve(25)
puts part_one_set.stones.size

puts "Part 2:"
part_two_set = StoneSet.new(initial_stones)
part_one_set.evolve(75)
puts part_two_set.stones.size

