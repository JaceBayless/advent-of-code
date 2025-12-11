class Map
  def initialize
    @red_tiles = []
    @edges = []
  end

  def add_red_tile(x:, y:)
    if @last_red_tile
      prev_x, prev_y = @last_red_tile

      @edges << [prev_x, prev_y, x, y]
    end

    @last_red_tile = [x, y]
    @red_tiles << [x, y]
  end

  def largest_green_area
    tiles = @red_tiles.combination(2).sort_by do |red_tile_a, red_tile_b|
      ((red_tile_a[0] - red_tile_b[0]).abs + 1) * ((red_tile_a[1] - red_tile_b[1]).abs + 1)
    end.reverse

    tiles.each_with_index do |(red_tile_a, red_tile_b), index|
      x_min, x_max = [red_tile_a[0], red_tile_b[0]].minmax
      y_min, y_max = [red_tile_a[1], red_tile_b[1]].minmax

      valid_rectangle = true

      (x_min..x_max).each do |x|
        break unless valid_rectangle
        valid_rectangle &&= inside?(x: x, y: y_max)
        valid_rectangle &&= inside?(x: x, y: y_min)
      end

      (y_min..y_max).each do |y|
        break unless valid_rectangle
        valid_rectangle &&= inside?(x: x_min, y: y)
        valid_rectangle &&= inside?(x: x_max, y: y)
      end

      # next puts "#{red_tile_a} #{red_tile_b} is not valid" unless valid_rectangle
      next unless valid_rectangle

      return ((red_tile_a[0] - red_tile_b[0]).abs + 1) * ((red_tile_a[1] - red_tile_b[1]).abs + 1)
    end

    nil
  end

  def inside?(x:, y:)
    @inside_cache ||= {}
    @inside_cache[y] ||= {}
    return @inside_cache[y][x] if !@inside_cache[y][x].nil?
    @inside_cache[y][x] = begin
      if on_vertical_edge?(x: x, y: y) || on_horizontal_edge?(x: x, y: y)
        true
      else
        crossings = scanline_crossings(y)
        boundaries = crossings.bsearch_index { _1 > x } || crossings.length
        boundaries.odd?
      end
    end
  end

  def scanline_crossings(y)
    @scanline_crossings ||= {}
    @scanline_crossings[y] ||= begin
      xs = []

      vertical_edges.each do |x, y_min, y_max|
        xs << x if y >= y_min && y < y_max
      end

      xs.sort
    end
  end

  def vertical_edges
    @vertical_edges ||= @edges.select { |x1, y1, x2, y2| x1 == x2 }.map { |x, y1, _, y2| [x, [y1, y2].min, [y1, y2].max] }
  end

  def on_vertical_edge?(x:, y:)
    scanline_crossings(y).include?(x)
  end

  def horizontal_edges
    @horizontal_edges ||= @edges.select { |x1, y1, x2, y2| y1 == y2 }.map { |x1, y, x2, _| [y, [x1, x2].min, [x1, x2].max] }
  end

  def on_horizontal_edge?(x:, y:)
    horizontal_edges.any? { |y1, x1, x2| y == y1 && x >= x1 && x <= x2 }
  end
end

map = Map.new
tiles = File.read("input.txt").split("\n").map { _1.split(",").map(&:to_i) }

tiles.each do |x, y|
  map.add_red_tile(x: x, y: y)
end
map.add_red_tile(x: tiles[0][0], y: tiles[0][1])

puts map.largest_green_area
