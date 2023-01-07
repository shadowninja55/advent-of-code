d = File.readlines("i.txt").map { _1.chomp.split("x").map(&:to_i) }

puts (d.map do |r| 
  a = r.combination(2).map { _1.inject(:*) }
  a.min + a.sum * 2
end).sum

puts d.map { _1.min(2).sum * 2 + _1.inject(:*) }.sum
