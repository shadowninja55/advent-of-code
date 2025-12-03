import re

p1 = p2 = 0

for r in open("i.txt").read().split(","):
  l, h = map(int, r.split("-"))
  for i in range(l, h + 1):
    if m := re.fullmatch(r"(.+)(\1+)", str(i)):
      p1 += i * (m.group(1) == m.group(2))
      p2 += i

print(p1, p2)
