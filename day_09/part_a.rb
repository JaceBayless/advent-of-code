data = File.read("day_09/input.txt")
in_pairs = data.chars.each_slice(2).to_a

my_arr = []
in_pairs.each_with_index do |pair, index|
  my_arr << ([index] * pair[0].to_i)
  my_arr << (["."] * pair[1].to_i)
end
my_arr.flatten!

(0..my_arr.length - 1).to_a.each do |i|
  if my_arr[i] == "."
    (0..my_arr.length - 1).to_a.each do |j|
      j_from_end = my_arr.length - j - 1
      break if i == j_from_end
      if my_arr[j_from_end] != "."
        my_arr[i] = my_arr[j_from_end]
        my_arr[j_from_end] = "."
        break
      end
    end
  end
end

sum = 0
my_arr.each_with_index do |char, i|
  break if char == "."
  sum += char * i
end
puts sum
