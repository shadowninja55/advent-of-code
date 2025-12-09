from itertools import combinations, pairwise

I = [tuple(map(int, l.split(","))) for l in open("i.txt")]
A = lambda u, v: (1 + abs(u[0] - v[0])) * (1 + abs(u[1] - v[1]))
B = lambda u, v: (min(u[0], v[0]), max(u[0], v[0]), min(u[1], v[1]), max(u[1], v[1]))
p1, p2 = max(A(u, v) for u, v in combinations(I, 2)), 0

for u, v in combinations(I, 2):
  rl, rr, rt, rb = B(u, v)
  for a, b in pairwise(I + [I[0]]):
    ll, lr, lt, lb = B(a, b)
    if ll < rr and lr > rl and lb > rt and lt < rb:
      break
  else:
    p2 = max(p2, A(u, v))

print(p1, p2)
