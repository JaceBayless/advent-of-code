def can_exit?(map:, x:, y:, impossible_positions: [])
  map[y][x] = "O"

  return false if impossible_positions.include?([[x, y]])
  return true if y == map.length - 1 && x == map[y].length - 1

  if y != map.length - 1 && map[y + 1][x] == "." && !impossible_positions.include?([x, y + 1])
    new_map = map.dup.map(&:dup)
    return true if can_exit?(map: new_map, x: x, y: y + 1, impossible_positions: impossible_positions)
  end

  if x != map[y].length - 1 && map[y][x + 1] == "." && !impossible_positions.include?([x + 1, y])
    new_map = map.dup.map(&:dup)
    return true if can_exit?(map: new_map, x: x + 1, y: y, impossible_positions: impossible_positions)
  end

  if x != 0 && map[y][x - 1] == "." && !impossible_positions.include?([x - 1, y])
    new_map = map.dup.map(&:dup)
    return true if can_exit?(map: new_map, x: x - 1, y: y, impossible_positions: impossible_positions)
  end

  if y != 0 && map[y - 1][x] == "." && !impossible_positions.include?([x, y - 1])
    new_map = map.dup.map(&:dup)
    return true if can_exit?(map: new_map, x: x, y: y - 1, impossible_positions: impossible_positions)
  end

  impossible_positions.append([x, y])
  false
end

data = File.read("day_18/input.txt").split("\n").map { _1.split(",").map(&:to_i) }
map = Array.new(71) { Array.new(71) { "." } }

data.each do |x, y|
  map[y][x] = "#"

  if !can_exit?(map: map, x: 0, y: 0)
    puts "#{x},#{y}"
    break
  end
end
