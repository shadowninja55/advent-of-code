G = {x + y * 1j: c == "@" for y, l in enumerate(open("i.txt")) for x, c in enumerate(l.strip())}
D = [-1, 1, 1j, -1j, -1 - 1j, -1 + 1j, 1 - 1j, 1 + 1j]
A = lambda p: G[p] and sum(G.get(p + d, False) for d in D) < 4
p1, p2 = sum(map(A, G)), 0

while r := {p: False for p in G if A(p)}:
  G |= r
  p2 += len(r)

print(p1, p2)
