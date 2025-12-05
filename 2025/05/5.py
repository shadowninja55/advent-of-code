F, A = [b.split() for b in open("i.txt").read().split("\n\n")]
F = [map(int, l.split("-")) for l in F]
A = map(int, A)

d, s, M = 0, None, []
for n, k in sorted(p[::-1] for r in F for p in enumerate(r)):
  d += -1 if k else 1
  if d == 1 and not k:
    s = n
  elif not d:
    M += [range(s, n + 1)]

p1 = sum(any(a in r for r in M) for a in A)
p2 = sum(map(len, M))

print(p1, p2)
