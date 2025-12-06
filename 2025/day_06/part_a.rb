# I used this one to get the answer.
puts File.read("input.txt").split("\n").map { _1.split(/\s+/).reject(&:empty?) }.transpose.sum { _1[0..-2].map(&:to_i).inject(_1[-1].to_sym) }

# I tried to golf this as much as possible.
# puts File.read("input.txt").split("\n").map { _1.split(" ") }.transpose.sum { _1[..-2].map(&:to_i).inject(_1[-1].to_sym) }