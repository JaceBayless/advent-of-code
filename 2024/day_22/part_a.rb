def calculate_next_secret(num)
  num = ((num * 64) ^ num) % 16777216
  num = ((num / 32.0).floor ^ num) % 16777216
  ((num * 2048) ^ num) % 16777216
end

data = File.read("day_22/input.txt").split("\n").map(&:to_i)

2000.times do
  data.map! do |num|
    calculate_next_secret(num)
  end
end

puts data.sum
