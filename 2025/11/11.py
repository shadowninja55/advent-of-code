from functools import cache

G = {k[:-1]: v for k, *v in map(str.split, open("i.txt"))}
D = cache(lambda c, g="out": c == g or sum(D(n, g) for n in G.get(c, [])))
print(D("you"), D("svr", "fft") * D("fft", "dac") * D("dac") + D("svr", "dac") + D("dac", "fft") + D("fft"))
