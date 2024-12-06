class OrderingRule
  getter before : Int32
  getter after : Int32

  def initialize(@before, @after)
  end

  def involves_any?(page_numbers : Array(PageNumber))
    page_numbers.any? { |page_number| involves?(page_number) }
  end

  def involves?(page_number : PageNumber)
    involves?(page_number.value)
  end

  def involves?(page_number : Int32)
    page_number == before || page_number == after
  end
end

class PageNumber
  getter value : Int32
  @ordering_rules : Array(OrderingRule)

  def initialize(@value, @ordering_rules)
  end

  def in_correct_spot?(previous, upcoming)
    others = previous + upcoming
    relevant_ordering_rules = @ordering_rules.select { |rule| rule.involves_any?(others) }

    return false unless prior_page_numbers_by_rule(others).all? { |n| n.in?(previous) }
    return false unless subsequent_page_numbers_by_rule(others).all? { |n| n.in?(upcoming) }

    true
  end

  def prior_page_numbers_by_rule(others)
    @ordering_rules
      .select { |rule| rule.involves_any?(others) }
      .select { |rule| self == rule.after }
      .map { |rule| others.find! { |n| n == rule.before } }
  end

  def subsequent_page_numbers_by_rule(others)
    @ordering_rules
      .select { |rule| rule.involves_any?(others) }
      .select { |rule| self == rule.before }
      .map { |rule| others.find! { |n| n == rule.after } }
  end

  def ==(page_number : Int32)
    @value == page_number
  end

  def ==(other : PageNumber)
    @value == other.value
  end
end

class UpdateSet
  getter page_numbers : Array(PageNumber)

  def initialize(@page_numbers)
  end

  def self.build(raw_page_numbers, all_ordering_rules)
    page_numbers = raw_page_numbers.map do |page_number|
      relevant_ordering_rules = all_ordering_rules.select { |rule| rule.involves?(page_number) }
      PageNumber.new(page_number, relevant_ordering_rules)
    end

    new(page_numbers)
  end

  def correctly_ordered?
    previous = [] of PageNumber
    upcoming = @page_numbers.dup

    while upcoming.any?
      current = upcoming.shift
      return false unless current.in_correct_spot?(previous, upcoming)
    end

    true
  end

  def in_correct_order
    return self if correctly_ordered?

    sorted_page_numbers = @page_numbers.sort_by! do |page_number|
      others = @page_numbers.reject { |n| n == page_number }
      page_number.prior_page_numbers_by_rule(others).size
    end

    UpdateSet.new(sorted_page_numbers)
  end

  def middle_page_number
    middle_index = (@page_numbers.size / 2).floor.to_i
    @page_numbers[middle_index]
  end
end


lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

raw_ordering_rules = [] of String
while lines.any?
  line = lines.shift
  break if line.blank?
  raw_ordering_rules << line
end
raw_update_sets = lines

ordering_rules = raw_ordering_rules.map do |raw_ordering_rule|
  before, after = raw_ordering_rule.split('|').map(&.to_i)
  OrderingRule.new(before, after)
end

update_sets = raw_update_sets.map do |raw_update_set|
  raw_page_numbers = raw_update_set.split(',').map(&.to_i)
  UpdateSet.build(raw_page_numbers, ordering_rules)
end

total = 0
update_sets.each do |update_set|
  if update_set.correctly_ordered?
    total += update_set.middle_page_number.value
  end
end

puts "Part 1:"
puts total
