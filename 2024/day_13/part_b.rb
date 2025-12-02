require "bigdecimal"

def calculate_min_cost(button_a, button_b, prize)
  button_a_presses = ((prize[0] - (button_b[0] * (prize[1] / button_b[1]))) / (button_a[0] - ((button_b[0] * button_a[1]) / button_b[1]))).round
  button_b_presses = ((prize[0] - (button_a_presses * button_a[0])) / button_b[0]).round

  valid = button_a_presses * button_a[0] + button_b_presses * button_b[0] == prize[0] && button_a_presses * button_a[1] + button_b_presses * button_b[1] == prize[1]
  return nil unless valid

  3 * button_a_presses + button_b_presses
end

data = File.read("day_13/input.txt").split("\n\n")
machines = data.map do |machine|
  button_a, button_b, prize = machine.split("\n")
  button_a = button_a.gsub("Button A: ", "").gsub("X+", "").gsub("Y+", "").split(", ").map(&:to_f)
  button_b = button_b.gsub("Button B: ", "").gsub("X+", "").gsub("Y+", "").split(", ").map(&:to_f)
  prize = prize.gsub("Prize: ", "").gsub("X=", "").gsub("Y=", "").split(", ").map(&:to_f)

  prize = [prize[0] + 10000000000000, prize[1] + 10000000000000]

  [button_a, button_b, prize]
end

costs = machines.map do |button_a, button_b, prize|
  calculate_min_cost(button_a, button_b, prize)
end.reject!(&:nil?)

puts costs.sum
