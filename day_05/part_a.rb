def update_is_ordered?(update, rules)
  ordered = true
  update.each_with_index do |page, index|
    must_be_before = rules.select { _1[0] == page }.map { _1[1] }
    must_be_after = rules.select { _1[1] == page }.map { _1[0] }

    ordered = false if (update[0..index] & must_be_before).any? || (update[index..] & must_be_after).any?
  end
  ordered
end

data = File.read("day_05/input.txt")

rules, updates = data.split("\n\n")

rules = rules.split("\n").map { _1.split("|").map(&:to_i) }
updates = updates.split("\n").map { _1.split(",").map(&:to_i) }

ordered_updates = updates.select do |update|
  update_is_ordered?(update, rules)
end

puts ordered_updates.sum { _1[_1.length / 2] }
