@memoizer = {}

def pattern_possibilities(desired_pattern:, available_patterns:)
  @memoizer[desired_pattern] ||= begin
    return 1 if desired_pattern == ""

    available_patterns.map do |available_pattern|
      next unless desired_pattern.start_with?(available_pattern)
      pattern_possibilities(desired_pattern: desired_pattern.sub(available_pattern, ""), available_patterns: available_patterns)
    end.compact.sum
  end
end

data = File.read("day_19/input.txt")

available_patterns, desired_patterns = data.split("\n\n")

available_patterns = available_patterns.split(", ")
desired_patterns = desired_patterns.split("\n")

total_possibilities = desired_patterns.sum do |desired_pattern|
  pattern_possibilities(desired_pattern: desired_pattern, available_patterns: available_patterns)
end

puts total_possibilities