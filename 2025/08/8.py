import numpy as np
from scipy.cluster.hierarchy import DisjointSet

P = np.loadtxt("i.txt", int, delimiter=",")
D = sorted((np.dot(w := u - v, w), tuple(u), tuple(v)) for i, u in enumerate(P) for v in P[i+1:])
C = DisjointSet(map(tuple, P))

for i, (_, u, v) in enumerate(D):
  C.merge(u, v)
  if i == 999:
    p1 = np.prod(sorted(map(len, C.subsets()))[:-4:-1])
  if len(C.subsets()) == 1:
    print(p1, u[0] * v[0])
    break
