class Map
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
      x_min, x_max = [red_tile_a[0], red_tile_b[0]].minmax
      y_min, y_max = [red_tile_a[1], red_tile_b[1]].minmax

      valid_rectangle = true

      (x_min + 1...x_max).each do |x|
        next unless valid_rectangle
        valid_rectangle = false unless inside?(x: x, y: y_max)
        valid_rectangle = false unless inside?(x: x, y: y_min)
      end

      (y_min + 1...y_max).each do |y|
        next unless valid_rectangle
        valid_rectangle = false unless inside?(x: x_min, y: y)
        valid_rectangle = false unless inside?(x: x_max, y: y)
      end

      next puts "#{red_tile_a} #{red_tile_b} is not valid" unless valid_rectangle

      return (red_tile_a[0] - red_tile_b[0] + 1).abs * (red_tile_a[1] - red_tile_b[1] + 1).abs
    end

    nil
  end

  def inside?(x:, y:)
    @max_scanned_x ||= {}

    @inside ||= {}
    @inside[y] ||= {}
    return @inside[y][x] if !@inside[y][x].nil?

    boundaries = @max_scanned_x.dig(y, :boundaries) || 0
    red_row = @max_scanned_x.dig(y, :red_row) || false
    prev_x = @max_scanned_x.dig(y, :x) || 0

    (prev_x + 1..x).each do |i|
      if @red_tiles.include?([i, y])
        red_row = !red_row
        boundaries += 1 if red_row
      elsif @green_tiles.include?([i, y])
        boundaries += 1 if !red_row
      end
      @inside[y][i] = boundaries.odd? || red_row
    end

    @max_scanned_x[y] = {
      x: x,
      red_row: red_row,
      boundaries: boundaries
    }

    @inside[y][x]
  end
end

map = Map.new
tiles = File.read("input.txt").split("\n").map { _1.split(",").map(&:to_i) }

tiles.each do |x, y|
  map.add_red_tile(x: x, y: y)
end
map.add_red_tile(x: tiles[0][0], y: tiles[0][1])

puts map.largest_green_area
