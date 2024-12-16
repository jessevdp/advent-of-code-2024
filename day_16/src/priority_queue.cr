class PriorityQueue(T)
  @queue = [] of T

  def initialize(&@calculate_priority : T -> Int32)
  end

  def any?
    @queue.any?
  end

  def <<(combination : T) : T
    @queue << combination
    @queue.sort_by! { |combination| @calculate_priority.call(combination) }
    combination
  end

  def shift
    @queue.shift
  end
end

