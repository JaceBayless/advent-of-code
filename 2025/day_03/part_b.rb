BATTERIES = 12

ans = File.read("input.txt").split("\n").sum do |row|
  max = []
  last_position = 0

  BATTERIES.times do |i|
    numbers = row.chars.map(&:to_i)

    purview = numbers[last_position..(-BATTERIES + i)]

    next_battery = purview.max
    next_batter_location_relative = purview.index(next_battery)

    max << next_battery
    last_position += next_batter_location_relative + 1
  end

  max.join.to_i
end

puts ans
