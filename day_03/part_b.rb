data = File.read("day_03/input.txt")

matches = data.scan(/mul\((\d{1,3},\d{1,3})\)|(don't\(\))|(do\(\))/).flatten.compact

enabled = true
sum = 0
matches.each do |match|
  if match == "don't()"
    enabled = false
  elsif match == "do()"
    enabled = true
  elsif enabled
    sum += match.split(",").map(&:to_i).inject(:*)
  end
end

puts sum
