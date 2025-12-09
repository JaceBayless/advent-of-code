class JunctionBox
  attr_reader :x, :y, :z

  def initialize(x:, y:, z:)
    @x = x
    @y = y
    @z = z
  end
end

class JunctionBoxesDistance
  attr_reader :junction_box_a, :junction_box_b, :distance

  def initialize(junction_box_a:, junction_box_b:)
    @junction_box_a = junction_box_a
    @junction_box_b = junction_box_b
    @distance = Math.sqrt((@junction_box_a.x - @junction_box_b.x)**2 + (@junction_box_a.y - @junction_box_b.y)**2 + (@junction_box_a.z - @junction_box_b.z)**2)
  end

  def junction_boxes
    [@junction_box_a, @junction_box_b]
  end

  def to_s
    "#{@junction_box_a.x},#{@junction_box_a.y},#{@junction_box_a.z} to #{@junction_box_b.x},#{@junction_box_b.y},#{@junction_box_b.z} - #{@distance}"
  end
end

class Circuit
  attr_reader :junction_boxes
  def initialize(*junction_boxes)
    @junction_boxes = junction_boxes
  end

  def add_junction_boxes(*junction_boxes)
    junction_boxes.each do |junction_box|
      next if include?(junction_box)
      @junction_boxes << junction_box
    end
  end

  def include?(*junction_boxes)
    junction_boxes.each do |junction_box|
      return true if @junction_boxes.include?(junction_box)
    end
    false
  end
end

junction_boxes = File.read("input.txt").split("\n").map do |line|
  x, y, z = line.split(",").map(&:to_i)
  JunctionBox.new(x: x, y: y, z: z)
end

distances = junction_boxes.combination(2).map do |junction_box_a, junction_box_b|
  JunctionBoxesDistance.new(junction_box_a: junction_box_a, junction_box_b: junction_box_b)
end

distances.sort_by!(&:distance)

circuits = []
distances.each do |distance|
  connected_existing_circuits = circuits.select { _1.include?(*distance.junction_boxes) }

  case connected_existing_circuits.length
  when 0
    new_circuit = Circuit.new(*distance.junction_boxes)
    circuits << new_circuit
  when 1
    connected_existing_circuits.first.add_junction_boxes(*distance.junction_boxes)
  when 2
    c1 = connected_existing_circuits.first
    c2 = connected_existing_circuits.last
    c1.add_junction_boxes(*c2.junction_boxes)
    circuits.delete(c2)
  end

  if circuits.first.junction_boxes.count == junction_boxes.count
    puts distance.junction_boxes.map(&:x).inject(&:*)
    break
  end
end
