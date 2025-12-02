position = 50
count = 0

File.readlines("input.txt").each do |instruction|
  direction = instruction[0]
  distance = instruction[1..].to_i

  distance.times do
    if direction == "L"
      position -= 1
    else
      position += 1
    end

    position = 99 if position == -1
    position = 0 if position == 100

    count += 1 if position == 0
  end
end

puts count
