data = File.read("day_02/input.txt").split("\n").map { _1.split.map(&:to_i) }

data = data.select do |level|
  level == level.sort || level == level.sort.reverse
end

data = data.select do |level|
  safe = true
  (0..level.length - 2).each do |i|
    diff = (level[i] - level[i + 1]).abs
    break safe = false if diff > 3 || diff == 0
  end
  safe
end

puts data.length
