grid = File.read("input.txt").split("\n").map(&:chars)

total_removed = 0
iteration_count = -1
while iteration_count != 0
  iteration_count = 0

  grid.each_with_index do |row, y|
    row.each_with_index do |char, x|
      next if char == "."

      surrounding_count = 0
      (-1..1).each do |y_delta|
        (-1..1).each do |x_delta|
          next if y_delta == 0 && x_delta == 0

          test_y = y + y_delta
          test_x = x + x_delta

          next if test_y < 0 || test_y >= grid.length || test_x < 0 || test_x >= grid[y].length

          surrounding_count += 1 if ["@", "X"].include?(grid.dig(test_y, test_x))
        end
      end

      if surrounding_count < 4
        grid[y][x] = "."
        iteration_count += 1
      end
    end
  end

  total_removed += iteration_count
end

puts total_removed
