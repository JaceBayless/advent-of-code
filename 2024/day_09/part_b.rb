def moved_data(new, old)
  old
end

data = File.read("day_09/input.txt")
in_pairs = data.chars.each_slice(2).to_a

my_arr = []
in_pairs.each_with_index do |pair, index|
  my_arr << ([index] * pair[0].to_i)
  my_arr << (["."] * pair[1].to_i)
end

my_arr.reject!(&:empty?)

i = 0
while my_arr.any? { _1.all?(".") }
  break if i == my_arr.length - 1
  to_move = my_arr[my_arr.length - i - 1]
  next i += 1 if to_move.all?(".")

  new_index = my_arr.index { _1.length >= to_move.length && _1.all?(".") }

  if new_index && new_index < my_arr.length - i - 1
    old_data = my_arr[new_index]
    delta = old_data.length - to_move.length

    my_arr[my_arr.length - i - 1] = to_move.map { "." }
    my_arr.insert(new_index + 1, ["."] * delta) if delta >= 1
    my_arr[new_index] = to_move
  end

  i += 1
end

sum = 0
my_arr.flatten.each_with_index do |char, i|
  next if char == "."
  sum += char * i
end
puts sum
