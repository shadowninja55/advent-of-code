def J(n, l):
  if n == 1: return max(l)
  i = l.index(max(l[:1-n]))
  return l[i] + J(n - 1, l[i+1:])

p1 = p2 = 0

for l in open("i.txt").read().split():
  p1 += int(J(2, l))
  p2 += int(J(12, l))

print(p1, p2)
