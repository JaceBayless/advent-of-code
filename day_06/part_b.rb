class Character
  attr_accessor :x, :y, :previous_positions

  def initialize(x:, y:, dir:, map:, previous_positions: nil)
    @x = x
    @y = y
    @dir = dir
    @map = map
    @previous_positions = [{x: @x, y: @y, dir: @dir}]
  end

  def velocity
    case @dir
    when "^" then {x: 0, y: -1}
    when ">" then {x: 1, y: 0}
    when "v" then {x: 0, y: 1}
    when "<" then {x: -1, y: 0}
    end
  end

  def can_move?
    @map.character_at(x: @x + velocity[:x], y: @y + velocity[:y]) != "#"
  end

  def at_the_end?
    @y <= 0 || @y >= @map.height - 1 || @x <= 0 || @x >= @map.width - 1
  end

  def move
    @map.update_character_at(x: @x, y: @y, char: "X")
    @x += velocity[:x]
    @y += velocity[:y]
    @map.update_character_at(x: @x, y: @y, char: @dir)
    @previous_positions << {x: @x, y: @y, dir: @dir}
  end

  def rotate
    @dir = case @dir
    when "^" then ">"
    when ">" then "v"
    when "v" then "<"
    when "<" then "^"
    end
    @map.update_character_at(x: @x, y: @y, char: @dir)
  end

  def looped?
    @previous_positions.count({x: @x, y: @y, dir: @dir}) > 1
  end
end

class Map
  attr_accessor :character

  def initialize(map, character_previous_positions = nil)
    @map = map

    start_char = map.map(&:join).join.scan(/\^|>|v|</)[0]
    start_y = map.index { _1.include?(start_char) }
    start_x = map[start_y].index(start_char)
    @character = Character.new(x: start_x, y: start_y, dir: start_char, map: self, previous_positions: character_previous_positions)
  end

  def character_at(x:, y:)
    @map[y][x]
  end

  def update_character_at(x:, y:, char:)
    @map[y][x] = char
  end

  def height
    @map.length
  end

  def width
    @map[0].length
  end

  def could_loop?
    new_map = Map.new(@map.dup.map(&:dup), @character.previous_positions.dup)
    new_map.update_character_at(x: @character.x + @character.velocity[:x], y: @character.y + @character.velocity[:y], char: "#")
    looper = new_map.character

    until looper.at_the_end?
      return true if looper.looped?

      if looper.can_move?
        looper.move
      else
        looper.rotate
      end
    end

    false
  end

  def solve
    loops = 0
    until @character.at_the_end?
      loops += 1 if could_loop?

      if @character.can_move?
        @character.move
      else
        @character.rotate
      end
    end

    puts loops
  end
end

map = Map.new(File.read("day_06/input.txt").split("\n").map { _1.chars })
map.solve
