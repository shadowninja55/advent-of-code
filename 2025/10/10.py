from z3 import *
from functools import reduce

p1 = p2 = 0

for l in open("i.txt"):
  L, *W, J = l.split()
  L = [c == "#" for c in L[1:-1]]
  W = [eval(s[:-1] + ",)") for s in W]
  J = eval(f"[{J[1:-1]}]")
  B = [f"b{i}" for i, _ in enumerate(W)]
  B1, B2 = list(map(Bool, B)), list(map(Int, B))
  s1, s2 = Optimize(), Optimize()
  s2.add(b >= 0 for b in B2)
  for i, (t, j) in enumerate(zip(L, J)):
    s1.add(reduce(Xor, (b for b, w in zip(B1, W) if i in w)) == t)
    s2.add(Sum(b for b, w in zip(B2, W) if i in w) == j)
  s1.minimize(n1 := Sum(B1))
  s2.minimize(n2 := Sum(B2))
  assert s1.check() == s2.check() == sat
  p1 += s1.model().evaluate(n1).as_long()
  p2 += s2.model().evaluate(n2).as_long()

print(p1, p2)
