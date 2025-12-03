invalid_ids = []

File.read("input.txt").split(",").each do |range_string|
  start_number, end_number = range_string.split("-").map(&:to_i)

  (start_number..end_number).each do |number|
    next if number < 10

    number_length = number.to_s.length
    sections = 2
    while sections <= number_length
      if number_length % sections == 0
        section_length = number_length / sections
        section = number.to_s[0..section_length - 1]

        if section * sections == number.to_s
          invalid_ids << number
          break
        end
      end
      sections += 1
    end
  end
end

puts invalid_ids.sum
