data = File.read("day_01/input.txt").split("\n")
data = data.map(&:split)

list_a = data.map { _1[0].to_i }.sort!
list_b = data.map { _1[1].to_i }.sort!

b_counts = list_b.tally

similarity_scores = list_a.map do |a|
  counts = b_counts[a]
  if counts
    counts * a
  else
    0
  end
end

puts similarity_scores.sum
