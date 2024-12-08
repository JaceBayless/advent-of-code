map = File.read("day_08/input.txt").split("\n").map { _1.chars }
annode_map = Array.new(map.length) { Array.new(map[0].length).map { "." } }

map.each_with_index do |row, y|
  row.each_with_index do |char, x|
    if char != "."
      map.each_with_index do |a_row, a_y|
        a_row.each_with_index do |a_char, a_x|
          if a_char == char && x != a_x && y != a_y
            annode_map[y][x] = "#"

            y_delta = y - a_y
            x_delta = x - a_x

            annode_y = y + y_delta
            annode_x = x + x_delta

            until annode_y < 0 || annode_y >= annode_map.length || annode_x < 0 || annode_x >= annode_map[0].length
              annode_map[annode_y][annode_x] = "#"

              annode_y += y_delta
              annode_x += x_delta
            end
          end
        end
      end
    end
  end
end

puts annode_map.sum { _1.count("#") }
