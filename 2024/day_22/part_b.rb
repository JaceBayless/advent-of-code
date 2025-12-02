class SecretMachine
  def initialize(i)
    numbers = []

    numbers << i
    2000.times do
      numbers << calculate_next_secret(numbers[-1] || i)
    end

    @delta_sequences_and_price = {}
    numbers.map { price(_1) }.each_cons(5).to_a.map do |cons|
      delta_sequence = cons.each_cons(2).to_a.map { _1[1] - _1[0] }
      price = price(cons[-1])

      @delta_sequences_and_price[delta_sequence] ||= price
    end
  end

  def delta_sequences
    @delta_sequences_and_price.keys
  end

  def price_for_sequence(sequence)
    @delta_sequences_and_price[sequence] || 0
  end

  def price(num)
    num % 10
  end

  def calculate_next_secret(num)
    num = ((num * 64) ^ num) % 16777216
    num = ((num / 32.0).floor ^ num) % 16777216
    ((num * 2048) ^ num) % 16777216
  end
end

data = File.read("day_22/input.txt").split("\n").map(&:to_i)

machines = data.map do |num|
  SecretMachine.new(num)
end

all_delta_sequences = machines.flat_map(&:delta_sequences).uniq

max_bananas = 0
all_delta_sequences.each_with_index do |sequence, index|
  bananas_for_sequence = machines.sum { _1.price_for_sequence(sequence) }
  if bananas_for_sequence > max_bananas
    max_bananas = bananas_for_sequence
  end
end

puts max_bananas
