class Machine
  class IndicatorLight
    def initialize(on)
      @on = on
    end

    def toggle!
      @on = !@on
    end

    def on?
      @on
    end

    def ==(other)
      @on == other.on?
    end
  end

  class Button
    attr_reader :toggles

    def initialize(toggles)
      @toggles = toggles
    end
  end

  attr_reader :indicator_lights, :buttons

  def initialize(line)
    split_line = line.split(" ")
    @indicator_lights = split_line[0].gsub(/\[|\]/, "").chars.map do |light|
      IndicatorLight.new(light == "#")
    end
    @buttons = split_line[1..-2].map do |button|
      Button.new(button.gsub(/\(|\)/, "").split(",").map(&:to_i))
    end
  end

  def fewest_press_required
    presses = 1
    loop do
      combinations = @buttons.combination(presses)

      combinations.any? do |combination|
        test_lights = Array.new(@indicator_lights.size) { IndicatorLight.new(false) }

        combination.each do |button|
          button.toggles.each do |toggle|
            test_lights[toggle].toggle!
          end
        end

        return presses if test_lights == @indicator_lights
      end

      presses += 1
    end
  end
end

machines = File.read("input.txt").split("\n").map do |line|
  Machine.new(line)
end

puts machines.sum(&:fewest_press_required)
