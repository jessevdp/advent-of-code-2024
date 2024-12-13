class ClawMachine
  ACTION_MAXIMUM = 100

  getter target : Point
  getter actions : Array(Action)

  def initialize(@target, @actions)
  end

  def possible?
    max = Point.new(0, 0)
    @actions.each do |action|
      ACTION_MAXIMUM.times do
        max += action
      end
    end

    (max.x >= target.x) && (max.y >= target.y)
  end
end

