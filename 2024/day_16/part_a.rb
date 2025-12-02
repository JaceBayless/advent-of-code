def find_cheapest_path(map:, x:, y:, dir:, points: 0, previous_paths: [], memoized_points: {})
  possible_points = []

  previous_paths << [y, x]

  return points + memoized_points[[y, x, dir]] if memoized_points[[y, x, dir]]
  return points if map[y][x] == "E"

  if map[y + 1][x] != "#" && !previous_paths.include?([y + 1, x])
    points_for_move = (dir == :south) ? 1 : 1001
    possible_points << find_cheapest_path(map: map, x: x, y: y + 1, dir: :south, points: points + points_for_move, previous_paths: previous_paths.dup, memoized_points: memoized_points)
  end

  if map[y][x + 1] != "#" && !previous_paths.include?([y, x + 1])
    points_for_move = (dir == :east) ? 1 : 1001
    possible_points << find_cheapest_path(map: map, x: x + 1, y: y, dir: :east, points: points + points_for_move, previous_paths: previous_paths.dup, memoized_points: memoized_points)
  end

  if map[y - 1][x] != "#" && !previous_paths.include?([y - 1, x])
    points_for_move = (dir == :north) ? 1 : 1001
    possible_points << find_cheapest_path(map: map, x: x, y: y - 1, dir: :north, points: points + points_for_move, previous_paths: previous_paths.dup, memoized_points: memoized_points)
  end

  if map[y][x - 1] != "#" && !previous_paths.include?([y, x - 1])
    points_for_move = (dir == :west) ? 1 : 1001
    possible_points << find_cheapest_path(map: map, x: x - 1, y: y, dir: :west, points: points + points_for_move, previous_paths: previous_paths.dup, memoized_points: memoized_points)
  end

  min = possible_points.reject { _1 == -1 }.min || -1
  memoized_points[[y, x, dir]] = (min == -1) ? -1 : min - points
  if previous_paths.length == 1
    puts min
    puts memoized_points
  end
  min
end

data = File.read("day_16/input_test.txt").split("\n").map(&:chars)

start_y = data.index { _1.include?("S") }
start_x = data[start_y].index("S")
puts find_cheapest_path(map: data, x: start_x, y: start_y, dir: :east)
