@memoizer = []

def pattern_is_possible?(desired_pattern:, available_patterns:)
  return false if @memoizer.include?(desired_pattern)
  return true if desired_pattern == ""

  available_patterns.each do |available_pattern|
    next unless desired_pattern.start_with?(available_pattern)
    possible = pattern_is_possible?(desired_pattern: desired_pattern.sub(available_pattern, ""), available_patterns: available_patterns)
    return true if possible
  end

  @memoizer << desired_pattern
  false
end

data = File.read("day_19/input.txt")

available_patterns, desired_patterns = data.split("\n\n")

available_patterns = available_patterns.split(", ")
desired_patterns = desired_patterns.split("\n")

possible_patterns = 0
desired_patterns.each do |desired_pattern|
  possible_patterns += 1 if pattern_is_possible?(desired_pattern: desired_pattern, available_patterns: available_patterns)
end

puts possible_patterns
