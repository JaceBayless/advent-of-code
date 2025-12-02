data = File.read("day_01/input.txt").split("\n")
data = data.map(&:split)

list_a = data.map { _1[0].to_i }.sort!
list_b = data.map { _1[1].to_i }.sort!

deltas = (0..list_a.length - 1).map do |i|
  delta = list_a[i] - list_b[i]
  if delta < 0
    delta * -1
  else
    delta
  end
end

puts deltas.sum
