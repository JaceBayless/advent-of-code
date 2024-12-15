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

  def display
    @height.times do |y|
      row = []
      @width.times do |x|
        robots_count = @robots.count { _1.x == x && _1.y == y }
        row << (robots_count.zero? ? "." : robots_count)
      end
      puts row.join
    end
  end

  def tick
    @robots.each { _1.move(max_x: @width, max_y: @height) }
  end
end

data = File.read("day_14/input.txt").split("\n")

# map = Map.new(width: 11, height: 7)
map = Map.new(width: 101, height: 103)

data.each do |row|
  pos, velocity = row.gsub(/p=|v=/, "").split(" ")
  x, y = pos.split(",").map(&:to_i)
  x_velocity, y_velocity = velocity.split(",").map(&:to_i)
  map.add_robot(x: x, y: y, x_velocity: x_velocity, y_velocity: y_velocity)
end

tick = 0
loop do
  system "clear"
  tick += 1
  map.tick
  if (tick - 68) % 101 == 0
    map.display
    puts "Tick: #{tick}"
    input = gets
    break if input != "\n"
  end
end
