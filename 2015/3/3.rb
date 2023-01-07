I = File.read("i.txt").chomp
D = "^>v<".chars.zip([1i, 1, -1i, -1]).to_h
def v l
  D.values_at(*l).inject([0+0i]) { |h, m| h << h.last + m }
end
puts v(I.chars).uniq.size
puts I.chars.each_slice(2).to_a.transpose.map { v _1 }.flatten.uniq.size
