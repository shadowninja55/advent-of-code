import math, sequtils, sugar

let grid = toSeq(lines("input.txt"))

proc solvePartOne(deltaX, deltaY: int): int =
    var x = 0

    for y in countup(0, grid.high, deltaY):
        result += int(grid[y][x] == '#')
        x = (x + deltaX) mod grid[0].len

proc solvePartTwo(deltas: varargs[(int, int)]): int =
    prod deltas.map(d => solvePartOne(d[0], d[1]))

echo solvePartOne(3, 1)
echo solvePartTwo((1, 1), (3, 1), (5, 1), (7, 1), (1, 2))