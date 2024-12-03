def is_safe?(report)
  return false unless report == report.sort || report == report.sort.reverse

  safe = true
  (0..report.length - 2).each do |i|
    diff = (report[i] - report[i + 1]).abs
    break safe = false if diff > 3 || diff == 0
  end
  safe
end

data = File.read("day_02/input.txt").split("\n").map { _1.split.map(&:to_i) }

data.select! do |report|
  safe = is_safe?(report)

  if !safe
    (0..report.length - 1).each do |i|
      new_report = report.dup
      new_report.delete_at(i)
      break safe = true if is_safe?(new_report)
    end
  end

  safe
end

puts data.length
