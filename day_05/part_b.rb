def update_is_ordered?(update, rules)
  ordered = true
  update.each_with_index do |page, index|
    must_be_before = rules.select { _1[0] == page }.map { _1[1] }
    must_be_after = rules.select { _1[1] == page }.map { _1[0] }

    ordered = false if (update[0..index] & must_be_before).any? || (update[index..] & must_be_after).any?
  end
  ordered
end

def fix_update(update, rules)
  new_update = update.dup

  new_update.each_with_index do |page, index|
    must_be_before = rules.select { _1[0] == page && update.include?(_1[1]) }.map { _1[1] }
    must_be_after = rules.select { _1[1] == page && update.include?(_1[0]) }.map { _1[0] }

    incorrectly_before = must_be_after & update[index + 1..]
    incorrectly_after = must_be_before & update[0..index]

    if incorrectly_before.any?
      furthest_index = incorrectly_before.map { update.index(_1) }.max
      new_update.insert(furthest_index + 1, page)
      new_update.delete_at(index)

      return fix_update(new_update, rules)
    end

    if incorrectly_after.any?
      furthest_index = incorrectly_after.map { update.index(_1) }.min
      new_update.insert(furthest_index, page)
      new_update.delete_at(index)

      return fix_update(new_update, rules)
    end
  end

  new_update
end

data = File.read("day_05/input.txt")

rules, updates = data.split("\n\n")

rules = rules.split("\n").map { _1.split("|").map(&:to_i) }
updates = updates.split("\n").map { _1.split(",").map(&:to_i) }

unordered_updates = updates.reject do |update|
  update_is_ordered?(update, rules)
end

corrected_updates = unordered_updates.map do |update|
  fix_update(update, rules)
end

puts corrected_updates.sum { _1[_1.length / 2] }