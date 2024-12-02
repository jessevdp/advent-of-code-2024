class Report
  SAFETY_THRESHOLD = 3

  def initialize(@levels = [] of Int32)
  end

  def safe?
    direction = nil
    @levels.each_cons_pair do |a, b|
      delta = b - a
      delta_direction = delta <=> 0
      direction ||= delta_direction

      return false if delta.abs > SAFETY_THRESHOLD
      return false if delta_direction != direction
    end

    true
  end

  def safe_when_dampened?
    return true if safe?

    dampened_permutations.each do |permutation|
      return true if permutation.safe?
    end

    false
  end

  def dampened_permutations
    @levels.map_with_index do |_, index|
      permutation = @levels.dup
      permutation.delete_at(index)
      Report.new(permutation)
    end
  end
end

