class Robot
  attr_accessor :x, :y

  def initialize(x:, y:, x_velocity:, y_velocity:)
    @x = x
    @y = y
    @x_velocity = x_velocity
    @y_velocity = y_velocity
  end

  def move(max_x:, max_y:)
    @x += @x_velocity
    @x %= max_x

    @y += @y_velocity
    @y %= max_y
  end
end

class Map
  def initialize(width:, height:)
    @width = width
    @height = height
    @map = Array.new(height) { Array.new(width) }
    @robots = []
  end

  def add_robot(...)
    @robots << Robot.new(...)
  end

  def tick
    @robots.each { _1.move(max_x: @width, max_y: @height) }
  end

  def safety_factor
    middle_width = (@width - 1) / 2
    middle_height = (@height - 1) / 2

    quad_1 = @robots.count { _1.x >= 0 && _1.x < middle_width && _1.y >= 0 && _1.y < middle_height }
    quad_2 = @robots.count { _1.x > middle_width && _1.x <= (@width - 1) && _1.y >= 0 && _1.y < middle_height }
    quad_3 = @robots.count { _1.x >= 0 && _1.x < middle_width && _1.y > middle_height && _1.y <= (@height - 1) }
    quad_4 = @robots.count { _1.x > middle_width && _1.x <= (@width - 1) && _1.y > middle_height && _1.y <= (@height - 1) }

    quad_1 * quad_2 * quad_3 * quad_4
  end
end

data = File.read("day_14/input.txt").split("\n")

map = Map.new(width: 101, height: 103)

data.each do |row|
  pos, velocity = row.gsub(/p=|v=/, "").split(" ")
  x, y = pos.split(",").map(&:to_i)
  x_velocity, y_velocity = velocity.split(",").map(&:to_i)
  map.add_robot(x: x, y: y, x_velocity: x_velocity, y_velocity: y_velocity)
end

100.times do
  map.tick
end

puts map.safety_factor
