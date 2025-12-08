def trickle(map, x, y, memo = {})
  return 1 if y == map.length - 1
  return memo[[x, y]] if memo[[x, y]]

  memo[[x, y]] = if map[y][x] == "."
    trickle(map, x, y + 1, memo)
  elsif map[y][x] == "^"
    left_paths = trickle(map, x - 1, y + 1, memo)
    right_paths = trickle(map, x + 1, y + 1, memo)
    return left_paths + right_paths
  end

  memo[[x, y]]
end

map = File.read("input.txt").split("\n").map(&:chars)

start_y = 1
start_x = map[0].index("S")

puts trickle(map, start_x, start_y)
