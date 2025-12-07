from collections import Counter as C

T = open("i.txt").read().split()
bs, p1 = {T[0].index("S"): 1}, 0

for r in T[1:]:
  bn, ss = C(), {i for i, c in enumerate(r) if c == "^"}
  p1 += len(set(bs) & ss)
  for b, n in bs.items():
    bn += C({b - 1: n, b + 1: n} if b in ss else {b: n})
  bs = bn

print(p1, bs.total())
