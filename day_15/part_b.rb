class Map
  def initialize(map_data)
    @map = map_data
  end

  def robot_y
    @map.index { _1.include?("@") }
  end

  def robot_x
    @map[robot_y].index("@")
  end

  def move(direction:, x: robot_x, y: robot_y)
    case direction
    when "^"
      if @map[y - 1][x] == "[" || @map[y - 1][x] == "]"
        move(direction: direction, x: x, y: y - 1)
      end

      if @map[y][x] == "@" && @map[y - 1][x] == "."
        @map[y - 1][x] = @map[y][x]
        @map[y][x] = "."
      elsif @map[y][x] == "["
        if @map[y - 1][x] == "." && @map[y - 1][x + 1] == "."
          @map[y - 1][x] = @map[y][x]
          @map[y - 1][x + 1] = @map[y][x + 1]
          @map[y][x] = "."
          @map[y][x + 1] = "."
        end
      elsif @map[y][x] == "]"
        if @map[y - 1][x] == "." && @map[y - 1][x - 1]
          @map[y - 1][x] = @map[y][x]
          @map[y - 1][x - 1] = @map[y][x - 1]
          @map[y][x] = "."
          @map[y][x - 1] = "."
        end
      end
    when ">"
      if @map[y][x + 1] == "[" || @map[y][x + 1] == "]"
        move(direction: direction, x: x + 1, y: y)
      end

      if @map[y][x + 1] == "."
        @map[y][x + 1] = @map[y][x]
        @map[y][x] = "."
      end
    when "v"
      if @map[y + 1][x] == "[" || @map[y + 1][x] == "]"
        move(direction: direction, x: x, y: y + 1)
      end

      if @map[y][x] == "@" && @map[y + 1][x] == "."
        @map[y + 1][x] = @map[y][x]
        @map[y][x] = "."
      elsif @map[y][x] == "["
        if @map[y + 1][x] == "." && @map[y + 1][x + 1] == "."
          @map[y + 1][x] = @map[y][x]
          @map[y + 1][x + 1] = @map[y][x + 1]
          @map[y][x] = "."
          @map[y][x + 1] = "."
        end
      elsif @map[y][x] == "]"
        if @map[y + 1][x] == "." && @map[y + 1][x - 1]
          @map[y + 1][x] = @map[y][x]
          @map[y + 1][x - 1] = @map[y][x - 1]
          @map[y][x] = "."
          @map[y][x - 1] = "."
        end
      end
    when "<"
      if @map[y][x - 1] == "[" || @map[y][x - 1] == "]"
        move(direction: direction, x: x - 1, y: y)
      end

      if @map[y][x - 1] == "."
        @map[y][x - 1] = @map[y][x]
        @map[y][x] = "."
      end
    end
  end

  def boxes_gps_sum
    sum = 0
    @map.length.times do |y|
      @map[y].length.times do |x|
        sum += 100 * y + x if @map[y][x] == "["
      end
    end
    sum
  end

  def display
    @map.each { puts _1.join }
  end
end

map_data, instructions = File.read("day_15/input_test.txt").split("\n\n")

map_data = map_data.split("\n").map do |row|
  row.chars.flat_map do |char|
    if char == "O"
      ["[", "]"]
    elsif char == "@"
      ["@", "."]
    else
      [char] * 2
    end
  end
end

instructions = instructions.chars

map = Map.new(map_data)

instructions.each do |instruction|
  map.move(direction: instruction)
  puts "\n"
  map.display
  puts "Previous instruction: #{instruction}"
  gets
end

map.display

puts map.boxes_gps_sum
