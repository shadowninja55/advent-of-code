import os

path = r"C:\\Users\\shado\\Desktop\\nim\\aoc-2020\\"

for i in range(1, 10):
    if i < 10:
        os.rename(path + str(i), path + "0" + str(i))