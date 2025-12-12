n = 0

for l in open("i.txt").read().split("\n\n")[-1].splitlines():
  wh, q = l.split(":")
  w, h = map(int, wh.split("x"))
  q = map(int, q.split())
  n += 8 * sum(q) <= w * h

print(n)
