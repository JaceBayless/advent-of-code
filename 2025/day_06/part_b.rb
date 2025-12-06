puts File.read("input.txt").split("\n").map(&:chars).transpose.slice_after { _1.all?(" ") }.to_a.sum { _1.map(&:join).map(&:to_i).reject(&:zero?).inject(_1[0][-1].to_sym) }
