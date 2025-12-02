class Character
  attr_accessor :x, :y

  def initialize(x:, y:, dir:, map:)
    @x = x
    @y = y
    @dir = dir
    @map = map
    @previous_positions = {}
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
    @previous_positions[[@x, @y, @dir]] = true
    @map.update_character_at(x: @x, y: @y, char: "X")
    @x += velocity[:x]
    @y += velocity[:y]
    @map.update_character_at(x: @x, y: @y, char: @dir)
  end

  def rotate
    @previous_positions[[@x, @y, @dir]] = true
    @dir = case @dir
    when "^" then ">"
    when ">" then "v"
    when "v" then "<"
    when "<" then "^"
    end
    @map.update_character_at(x: @x, y: @y, char: @dir)
  end

  def looped?
    !!@previous_positions[[@x, @y, @dir]]
  end
end

class Map
  attr_accessor :character

  def initialize(map)
    @map = map

    start_char = map.map(&:join).join.scan(/\^|>|v|</)[0]
    start_y = map.index { _1.include?(start_char) }
    start_x = map[start_y].index(start_char)
    @character = Character.new(x: start_x, y: start_y, dir: start_char, map: self)
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
    # Can't block a previous path
    return false if character_at(x: @character.x + @character.velocity[:x], y: @character.y + @character.velocity[:y]) == "X"

    new_map = Map.new(@map.dup.map(&:dup))
    looper = new_map.character
    new_map.update_character_at(x: looper.x + looper.velocity[:x], y: looper.y + looper.velocity[:y], char: "#")

    until looper.at_the_end?
      if looper.can_move?
        looper.move
      else
        looper.rotate
      end

      return [@character.x + @character.velocity[:x], @character.y + @character.velocity[:y]] if looper.looped?
    end

    false
  end

  def solve
    loops = []
    until @character.at_the_end?
      if @character.can_move?
        loop = could_loop?
        loops << loop if loop
        @character.move
      else
        @character.rotate
      end
    end

    puts loops.uniq.length
  end
end

map = Map.new(File.read("day_06/input.txt").split("\n").map { _1.chars })
map.solve
