require "./point"
require "./action"
require "./priority_queue"
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
  .select(&.possible?)
  .map(&.cheapest_combination)
  .compact
  .map(&.total_cost)
  .sum

