data = File.read("day_04/input.txt").split("\n").map(&:chars)

count = 0
(1..data.length - 2).to_a.each do |y|
  (1..data[y].length - 2).to_a.map do |x|
    if data[y][x] == "A"
      if [data[y - 1][x - 1], data[y + 1][x + 1]].sort == ["M", "S"] && [data[y + 1][x - 1], data[y - 1][x + 1]].sort == ["M", "S"]
        count += 1
      end
    end
  end
end

puts count
