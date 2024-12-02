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
end

