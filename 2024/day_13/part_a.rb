def calculate_min_cost(button_a, button_b, prize)
  min_cost = 1000000

  100.times do |button_a_clicks|
    100.times do |button_b_clicks|
      x = button_a_clicks * button_a[0] + button_b_clicks * button_b[0]
      y = button_a_clicks * button_a[1] + button_b_clicks * button_b[1]

      if x == prize[0] && y == prize[1]
        cost = 3 * button_a_clicks + button_b_clicks
        min_cost = cost if cost < min_cost
      end
    end
  end

  (min_cost == 1000000) ? nil : min_cost
end

data = File.read("day_13/input.txt").split("\n\n")
machines = data.map do |machine|
  button_a, button_b, prize = machine.split("\n")
  button_a = button_a.gsub("Button A: ", "").gsub("X+", "").gsub("Y+", "").split(", ").map(&:to_i)
  button_b = button_b.gsub("Button B: ", "").gsub("X+", "").gsub("Y+", "").split(", ").map(&:to_i)
  prize = prize.gsub("Prize: ", "").gsub("X=", "").gsub("Y=", "").split(", ").map(&:to_i)

  [button_a, button_b, prize]
end

costs = machines.map do |button_a, button_b, prize|
  calculate_min_cost(button_a, button_b, prize)
end.reject!(&:nil?)

puts costs.sum
