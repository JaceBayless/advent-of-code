points = File.read("input.txt").split("\n").map { _1.split(",").map(&:to_i) }

largest_area = 0
points.combination(2).map do |point_a, point_b|
  area = (point_a[0] - point_b[0] + 1).abs * (point_a[1] - point_b[1] + 1).abs
  largest_area = area if area > largest_area
end

puts largest_area
