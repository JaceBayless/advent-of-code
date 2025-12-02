def calculate(a)
  if a == 0
    1
  elsif a.to_s.length.even?
    middle = (a.to_s.length / 2)
    num_1 = a.to_s[..middle - 1].to_i
    num_2 = a.to_s[middle..].to_i
    [num_1, num_2]
  else
    a * 2024
  end
end

data = File.read("day_11/input.txt").split(" ").map(&:to_i)

25.times do
  data.map! { |a| calculate(a) }.flatten!
end

puts data.length
