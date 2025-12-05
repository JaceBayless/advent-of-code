class FreshIdRange
  attr_reader :start, :end

  def initialize(s, e)
    @start = s
    @end = e
  end

  def overlaps?(other)
    @start.between?(other.start, other.end) || @end.between?(other.start, other.end) || other.start.between?(@start, @end) || other.end.between?(@start, @end)
  end

  def merge(other)
    @start = [@start, other.start].min
    @end = [@end, other.end].max
  end

  def length
    @end - @start + 1
  end
end

fresh_id_ranges = File.read("input.txt").split("\n\n")[0].split("\n").map { FreshIdRange.new(*_1.split("-").map(&:to_i)) }

index = 0
while (index += 1) < fresh_id_ranges.length
  check_index = 0

  while check_index < index
    if fresh_id_ranges[index].overlaps?(fresh_id_ranges[check_index])
      fresh_id_ranges[check_index].merge(fresh_id_ranges[index])
      fresh_id_ranges.delete_at(index)
      index = 0
      break
    end
    check_index += 1
  end
end

puts fresh_id_ranges.sum { _1.length }
