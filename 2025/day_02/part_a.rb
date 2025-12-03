invalid_ids = []

File.read("input.txt").split(",").each do |range_string|
  start_number, end_number = range_string.split("-").map(&:to_i)
  (start_number..end_number).each do |number|
    next if number < 10
    part_one = number.to_s[0..number.to_s.length / 2 - 1]
    part_two = number.to_s[number.to_s.length / 2..]

    invalid = part_one == part_two

    invalid_ids << number if invalid
  end
end

puts invalid_ids.sum
