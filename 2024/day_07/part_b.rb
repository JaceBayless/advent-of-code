def valid?(target:, numbers:)
  return false if target < 0

  a = numbers[0]
  b = numbers[1]

  mult_ans = a * b
  add_ans = a + b
  conn_ans = (a.to_s + b.to_s).to_i

  if numbers.length == 2
    mult_ans == target || add_ans == target || conn_ans == target
  else
    valid?(numbers: [mult_ans] + numbers[2..], target: target) || valid?(numbers: [add_ans] + numbers[2..], target: target) || valid?(numbers: [conn_ans] + numbers[2..], target: target)
  end
end

data = File.read("day_07/input.txt").split("\n")
data = data.map do |line|
  a, b = line.split(":")
  [a.to_i, b.split(" ").map(&:to_i)]
end

valid_rows = data.select do |target, numbers|
  valid?(target: target, numbers: numbers)
end

puts valid_rows.sum { _1[0] }
