require "./location_list"

lines = if ARGV.size > 0
  filepath = ARGV.first
  File.read_lines(filepath)
else
  [] of String
end

column_1 = [] of LocationList::LocationID
column_2 = [] of LocationList::LocationID
lines.each do |line|
  values = line.split
  column_1 << values.pop.to_i
  column_2 << values.pop.to_i
end

list_1 = LocationList.new(column_1)
list_2 = LocationList.new(column_2)

puts list_1.difference_to(list_2)
