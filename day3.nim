import sequtils
import sugar
import math

let grid = toSeq(lines("input.txt"))
let (height, width) = (grid.len, grid[0].len)

proc solvePartOne(deltaX, deltaY: int): int =
    var x = 0

    for y in countup(0, height - 1, deltaY):
        if grid[y][x] == '#': 
            inc result
            
        x += deltaX
        while x >= width:
            x -= width

proc solvePartTwo(deltas: varargs[(int, int)]): int =
    prod(deltas.map(d => solvePartOne(d[0], d[1])))

echo solvePartOne(3, 1)
echo solvePartTwo((1, 1), (3, 1), (5, 1), (7, 1), (1, 2))