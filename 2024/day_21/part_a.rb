KEYPAD = [
  ["7", "8", "9"],
  ["4", "5", "6"],
  ["1", "2", "3"],
  [nil, "0", "A"]
]

DIRECTIONS = [
  [nil, "^", "A"],
  ["<", "v", ">"]
]

def moves_to_type(key_map:, to_type:, start_x:, start_y:)
  movements = []
  x = start_x
  y = start_y

  to_type.chars.each do |target_key|
    target_y = key_map.index { _1.include?(target_key) }
    target_x = key_map[target_y].index(target_key)

    while x != target_x || y != target_y
      if target_x > x && !key_map[y][x + 1].nil?
        x += 1
        movements.append(">")
      elsif target_y < y && !key_map[y - 1][x].nil?
        y -= 1
        movements.append("^")
      elsif target_y > y && !key_map[y + 1][x].nil?
        y += 1
        movements.append("v")
      elsif target_x < x && !key_map[y][x - 1].nil?
        x -= 1
        movements.append("<")
      end
    end
    movements.append("A")
  end

  movements.join
end

# inputs = File.read("day_21/input_test.txt").split("\n")

# num_pad_inputs = inputs.map do |input|
#   moves_to_type(key_map: KEYPAD, to_type: input, start_x: 2, start_y: 3)
# end

# final = num_pad_inputs
# 2.times do
#   final.map! do |input|
#     moves_to_type(key_map: DIRECTIONS, to_type: input, start_x: 2, start_y: 0)
#   end
# end

# final.each_with_index do |input, i|
#   puts "#{input.length} * #{inputs[i].to_i}"
# end

one = moves_to_type(key_map: KEYPAD, to_type: "379A", start_x: 2, start_y: 3)
two = moves_to_type(key_map: DIRECTIONS, to_type: one, start_x: 2, start_y: 0)
thr = moves_to_type(key_map: DIRECTIONS, to_type: two, start_x: 2, start_y: 0)

puts thr.length
puts thr
puts two
puts one
puts "029A"
