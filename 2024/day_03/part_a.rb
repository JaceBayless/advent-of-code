data = File.read("day_03/input.txt")

matches = data.scan(/mul\((\d{1,3},\d{1,3})\)/).flatten

puts matches.sum { _1.split(",").map(&:to_i).inject(:*) }
