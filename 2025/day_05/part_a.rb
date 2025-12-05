fresh_ids, ingredient_ids = File.read("input.txt").split("\n\n")

fresh_ids = fresh_ids.split("\n").map { _1.split("-").map(&:to_i) }

ingredient_ids = ingredient_ids.split("\n").map(&:to_i)

fresh_count = ingredient_ids.count do |ingredient_id|
  fresh_ids.any? do |fresh_id|
    ingredient_id >= fresh_id[0] && ingredient_id <= fresh_id[1]
  end
end

puts fresh_count
