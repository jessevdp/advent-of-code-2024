require "./point"
require "./action"
require "./combination"
require "./claw_machine"
require "./claw_machines_configuration_parser"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

claw_machines = ClawMachinesConfigurationParser.new(lines).parse

puts "Part 1:"
puts claw_machines
  .select { |machine| machine.possible_with_budget?(100) }
  .map(&.cheapest_combination)
  .compact
  .map(&.total_cost)
  .sum

puts "Part 2:"
claw_machines.each do |machine|
  machine.target = Point.new(
    x: machine.target.x + 10000000000000,
    y: machine.target.y + 10000000000000,
  )
end
puts claw_machines
  .map(&.cheapest_combination)
  .compact
  .map(&.total_cost)
  .sum

