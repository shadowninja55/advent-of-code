p1, p2, d = 0, 0, 50

for l in open("i.txt"):
  for _ in range(int(l[1:])):
    d += {"L": -1, "R": 1}[l[0]]
    p2 += not d % 100
  p1 += not d % 100

print(p1, p2)
