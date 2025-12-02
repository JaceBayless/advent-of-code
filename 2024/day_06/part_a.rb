def move(map)
  start_char = map.map(&:join).join.scan(/\^|>|v|</)[0]
  y = map.index { _1.include?(start_char) }
  x = map[y].index(start_char)

  move_y, move_x = case map[y][x]
  when "^" then [-1, 0]
  when ">" then [0, 1]
  when "v" then [1, 0]
  when "<" then [0, -1]
  end

  new_y = y + move_y
  new_x = x + move_x

  out_of_bounds = new_y < 0 || new_y >= map.length || new_x < 0 || new_x >= map[new_y].length
  if out_of_bounds
    map[y][x] = "X"
    return false
  end

  if map[new_y][new_x] == "#"
    map[y][x] = case map[y][x]
    when "^" then ">"
    when ">" then "v"
    when "v" then "<"
    when "<" then "^"
    end
  else
    map[new_y][new_x] = map[y][x]
    map[y][x] = "X"
  end

  true
end

data = File.read("day_06/input.txt")
map = data.split("\n").map { _1.chars }

while move(map)
  # noop
end

puts map.sum { _1.count("X") }
