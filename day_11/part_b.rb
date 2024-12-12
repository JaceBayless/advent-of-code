def calculate(a)
  @memo ||= {}
  @memo[a] ||= begin
    if a == 0
      [1]
    elsif a.to_s.length.even?
      middle = (a.to_s.length / 2)
      num_1 = a.to_s[..middle - 1].to_i
      num_2 = a.to_s[middle..].to_i
      [num_1, num_2]
    else
      [a * 2024]
    end
  end
end

data = File.read("day_11/input.txt").split(" ").map(&:to_i).tally

75.times do
  new_data = {}
  data.each do |num, count|
    new_num = calculate(num)
    new_num.each do |num|
      new_data[num] ||= 0
      new_data[num] += count
    end
  end
  data = new_data
end

puts data.values.sum
