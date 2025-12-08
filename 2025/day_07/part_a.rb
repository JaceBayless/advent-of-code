map = File.read("input.txt").split("\n").map(&:chars)

height = map.length
width = map[0].length
split_count = 0

height.times do |y|
  width.times do |x|
    next if y == 0

    if ["|", "S"].include?(map[y - 1][x])
      if map[y][x] == "^"
        map[y][x - 1] = "|"
        map[y][x + 1] = "|"
        split_count += 1
      else
        map[y][x] = "|"
      end
    end
  end
end

puts split_count
