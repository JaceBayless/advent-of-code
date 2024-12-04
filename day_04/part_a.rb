data = File.read("day_04/input.txt").split("\n").map(&:chars)

target_word = "XMAS"

count = 0
data.length.times do |y|
  data[y].length.times do |x|
    next if data[y][x] != target_word[0]

    possible_directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

    valid_words = possible_directions.map do |y_delta, x_delta|
      valid = true
      current_y_delta = y_delta
      current_x_delta = x_delta

      target_word[1..].chars.each do |target_letter|
        test_y = y + current_y_delta
        test_x = x + current_x_delta

        break valid = false if test_y < 0 || test_y >= data.length
        break valid = false if test_x < 0 || test_x >= data[y].length
        break valid = false if data[test_y][test_x] != target_letter

        current_y_delta += y_delta
        current_x_delta += x_delta
      end

      valid
    end

    count += valid_words.count(true)
  end
end

puts count
