position = 50
count = 0

File.readlines("input.txt").each do |instruction|
  direction = instruction[0]
  distance = instruction[1..].to_i

  distance %= 100

  if direction == "L"
    position += distance
  else
    position -= distance
  end

  if position < 0
    position += 100
  elsif position > 99
    position -= 100
  end

  count += 1 if position == 0
end

puts count
