import numpy as np
from itertools import groupby

I = open("i.txt").read().splitlines()
O = [{"+": np.sum, "*": np.prod}[s] for s in I[-1].split()]
S = lambda m: sum(f(a) for f, a in zip(O, m))
p1 = S(np.array([l.split() for l in I[:-1]], int).T)

M = np.array([list(l) for l in I[:-1]]).T
p2 = S(list(map(int, r)) for k, r in groupby(map("".join, M), str.isspace) if not k)

print(p1, p2)
