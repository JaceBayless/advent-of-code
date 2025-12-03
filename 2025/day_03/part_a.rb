ans = File.read("input.txt").split("\n").sum do |row|
  numbers = row.chars.map(&:to_i)

  tens = numbers[..-2].max
  tens_location = numbers.index(tens)

  ones = numbers[tens_location + 1..].max
  tens * 10 + ones
end

puts ans
