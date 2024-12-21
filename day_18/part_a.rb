def shortest_exit_path(map:, x:, y:, length: 0, shortest_to_point: {})
  possible_paths = []

  current_shortest = shortest_to_point[[x, y]]
  return if current_shortest && current_shortest <= length

  shortest_to_point[[x, y]] = length
  map[y][x] = "O"

  return length if y == map.length - 1 && x == map[y].length - 1

  if y != 0 && map[y - 1][x] == "."
    new_map = map.dup.map(&:dup)
    possible_paths.append(shortest_exit_path(map: new_map, x: x, y: y - 1, length: length + 1, shortest_to_point: shortest_to_point))
  end

  if y != map.length - 1 && map[y + 1][x] == "."
    new_map = map.dup.map(&:dup)
    possible_paths.append(shortest_exit_path(map: new_map, x: x, y: y + 1, length: length + 1, shortest_to_point: shortest_to_point))
  end

  if x != 0 && map[y][x - 1] == "."
    new_map = map.dup.map(&:dup)
    possible_paths.append(shortest_exit_path(map: new_map, x: x - 1, y: y, length: length + 1, shortest_to_point: shortest_to_point))
  end

  if x != map[y].length - 1 && map[y][x + 1] == "."
    new_map = map.dup.map(&:dup)
    possible_paths.append(shortest_exit_path(map: new_map, x: x + 1, y: y, length: length + 1, shortest_to_point: shortest_to_point))
  end

  possible_paths.compact.min
end

data = File.read("day_18/input.txt").split("\n").map { _1.split(",").map(&:to_i) }
map = Array.new(71) { Array.new(71) { "." } }

data.first(1024).each do |x, y|
  map[y][x] = "#"
end

puts shortest_exit_path(map: map, x: 0, y: 0)
