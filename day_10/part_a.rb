def reachable_peaks(topograph, x:, y:)
  current_height = topograph[y][x]
  return {x: x, y: y} if current_height == 9

  child_path_scores = []

  child_path_scores.append(reachable_peaks(topograph, y: y - 1, x: x)) if y != 0 && topograph[y - 1][x] == current_height + 1 
  child_path_scores.append(reachable_peaks(topograph, y: y + 1, x: x)) if y != topograph.length - 1 && topograph[y + 1][x] == current_height + 1
  child_path_scores.append(reachable_peaks(topograph, y: y, x: x - 1)) if x != 0 && topograph[y][x - 1] == current_height + 1
  child_path_scores.append(reachable_peaks(topograph, y: y, x: x + 1)) if x != topograph[y].length - 1 && topograph[y][x + 1] == current_height + 1

  child_path_scores.flatten.uniq
end

topograph = File.read("day_10/input.txt").split("\n").map { _1.chars.map(&:to_i) }

trailheads_scores = []
topograph.length.times do |y|
  topograph[y].length.times do |x|
    if topograph[y][x] == 0
      trailheads_scores << reachable_peaks(topograph, x: x, y: y).length
    end
  end
end

puts trailheads_scores.sum
