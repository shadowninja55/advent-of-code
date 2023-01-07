s = File.read "i.txt"
d = s.chars.inject([0]) { |d, c| d << d.last + (-1) ** "()".index(c) }
puts d.last
puts d.index(-1)
