def calculate(registers, program)
  output = []
  i = 0
  while i <= (program.size - 1) / 2
    opcode = program[i * 2]
    operand = program[i * 2 + 1]

    literal_operand = operand
    combo_operand = if operand <= 3
      operand
    elsif operand == 4
      registers["A"]
    elsif operand == 5
      registers["B"]
    elsif operand == 6
      registers["C"]
    end

    case opcode
    when 0
      registers["A"] = (registers["A"] / (2**combo_operand)).floor
    when 1
      registers["B"] = registers["B"] ^ literal_operand
    when 2
      registers["B"] = combo_operand % 8
    when 3
      if registers["A"] != 0
        i = literal_operand
        next
      end
    when 4
      registers["B"] = registers["B"] ^ registers["C"]
    when 5
      output << combo_operand % 8
    when 6
      registers["B"] = (registers["A"] / (2**combo_operand)).floor
    when 7
      registers["C"] = (registers["A"] / (2**combo_operand)).floor
    end

    break if output.size > 0 && output != program.slice(0, output.size)
    i += 1
  end

  output
end

data = File.read("day_17/input.txt")
registers_data, program_data = data.split("\n\n")

registers = registers_data.split("\n").map do |data|
  register = data.match(/Register (A|B|C): /).captures[0]
  value = data.gsub(/Register (A|B|C): /, "").to_i
  [register, value]
end.to_h

program = program_data.gsub("Program: ", "").split(",").map(&:to_i)

i = 0
loop do
  puts i if i % 1_000_000 == 0
  registers["A"] = i
  output = calculate(registers, program)
  break if output == program
  i += 1
end

puts i
