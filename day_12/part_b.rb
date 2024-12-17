class Region
  def initialize(width:, height:, positions:)
    @map = Array.new(height) { Array.new(width) }

    positions.each do |position|
      add_point(x: position[:x], y: position[:y])
    end
  end

  def contains?(x:, y:)
    return false if x < 0 || x >= @map[0].length || y < 0 || y >= @map.length
    @map.dig(y, x) == "X"
  end

  def add_point(x:, y:)
    @map[y][x] = "X"
  end

  def price
    area * sides
  end

  def area
    @map.sum do |row|
      row.count { !_1.nil? }
    end
  end

  def sides
    sides_count = 0

    @map.length.times do |y|
      @map[y].length.times do |x|
        next unless contains?(x: x, y: y)

        if (y == 0 && !contains?(x: x - 1, y: y)) || (!contains?(x: x, y: y - 1) && (!contains?(x: x - 1, y: y) || contains?(x: x - 1, y: y - 1)))
          sides_count += 1
        end
        if (y == @map.length - 1 && !contains?(x: x - 1, y: y)) || (!contains?(x: x, y: y + 1) && (!contains?(x: x - 1, y: y) || contains?(x: x - 1, y: y + 1)))
          sides_count += 1
        end
        if (x == 0 && !contains?(x: x, y: y - 1)) || (!contains?(x: x - 1, y: y) && (!contains?(x: x, y: y - 1) || contains?(x: x - 1, y: y - 1)))
          sides_count += 1
        end
        if (x == @map[y].length - 1 && !contains?(x: x, y: y - 1)) || (!contains?(x: x + 1, y: y) && (!contains?(x: x, y: y - 1) || contains?(x: x + 1, y: y - 1)))
          sides_count += 1
        end
      end
    end

    sides_count
  end
end

def all_positions_for_region(map, x:, y:, target_char: nil, positions: [])
  target_char ||= map[y][x]

  return [] if map.dig(y, x) != target_char || x < 0 || y < 0 || x >= map[0].length || y >= map.length
  positions.append(x: x, y: y)
  positions.append(*all_positions_for_region(map, x: x, y: y - 1, target_char: target_char, positions: positions)) if !positions.include?(x: x, y: y - 1)
  positions.append(*all_positions_for_region(map, x: x + 1, y: y, target_char: target_char, positions: positions)) if !positions.include?(x: x + 1, y: y)
  positions.append(*all_positions_for_region(map, x: x, y: y + 1, target_char: target_char, positions: positions)) if !positions.include?(x: x, y: y + 1)
  positions.append(*all_positions_for_region(map, x: x - 1, y: y, target_char: target_char, positions: positions)) if !positions.include?(x: x - 1, y: y)

  positions.uniq
end

map = File.read("day_12/input.txt").split("\n").map { _1.chars }

height = map.length
width = map[0].length

regions = []
map.each_with_index do |col, y|
  col.each_with_index do |row, x|
    next if regions.any? { _1.contains?(x: x, y: y) }
    positions = all_positions_for_region(map, x: x, y: y)
    regions << Region.new(width: width, height: height, positions: positions)
  end
end

puts regions.sum(&:price)
