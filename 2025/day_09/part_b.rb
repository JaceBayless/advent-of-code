class Map
  DIMENSION = 100000

  def initialize
    @red_tiles = Set[]
    @green_tiles = Set[]
  end

  def add_red_tile(x:, y:)
    if @last_red_tile
      prev_x = @last_red_tile[0]
      prev_y = @last_red_tile[1]

      x_range = ([x, prev_x].min + 1)..([x, prev_x].max - 1)
      y_range = ([y, prev_y].min + 1)..([y, prev_y].max - 1)

      x_range.each do |i|
        @green_tiles << [i, y]
      end

      y_range.each do |i|
        @green_tiles << [x, i]
      end
    end

    @last_red_tile = [x, y]
    @red_tiles << [x, y]
  end

  def largest_green_area
    tiles = @red_tiles.to_a.combination(2).sort_by do |red_tile_a, red_tile_b|
      (red_tile_a[0] - red_tile_b[0] + 1).abs * (red_tile_a[1] - red_tile_b[1] + 1).abs
    end.reverse

    tiles.each do |red_tile_a, red_tile_b|
      y_points = [red_tile_a[1], red_tile_b[1]]
      y_range = y_points.min..y_points.max

      x_points = [red_tile_a[0], red_tile_b[0]]
      x_range = x_points.min..x_points.max

      valid = true
      y_range.each do |y|
        x_range.each do |x|
          valid = false if !green_or_red_tile?(x: x, y: y)
          break if !valid
        end
        break if !valid
      end

      return y_range.count * x_range.count if valid
    end
  end

  private

  def green_or_red_tile?(x:, y:)
    @red_or_green_tiles ||= {}
    return @red_or_green_tiles[[x, y]] if @red_or_green_tiles[[x, y]]

    red_row = false
    last_known = @red_or_green_tiles.keys.select { _1[1] == y }.max_by { _1[0] } || [0, y]
    boundary_tiles = @red_or_green_tiles[last_known] ? 1 : 0
    (((last_known[0] + 1) || 0)..x).each do |i|
      if @red_tiles.include?([i, y])
        boundary_tiles += 1 if !red_row

        red_row = !red_row
      elsif !red_row && @green_tiles.include?([i, y])
        boundary_tiles += 1
      end

      @red_or_green_tiles[[i, y]] = boundary_tiles.odd?
    end

    @red_or_green_tiles[[x, y]]
  end
end

map = Map.new
tiles = File.read("input_test.txt").split("\n").map { _1.split(",").map(&:to_i) }

tiles.each do |x, y|
  map.add_red_tile(x: x, y: y)
end
map.add_red_tile(x: tiles[0][0], y: tiles[0][1])

puts map.largest_green_area
