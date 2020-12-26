import tables, sets

proc `+=`(a: var (int, int), b: (int, int)) =
  a = (a[0] + b[0], a[1] + b[1])

const dirs = {
  '^': (0, 1),
  'v': (0, -1),
  '<': (-1, 0),
  '>': (1, 0)
}.toTable()

proc solvePartOne: int =
  var 
    visited = [(0, 0)].toHashSet()
    pos = (0, 0)

  for c in readFile "input.txt":
    pos += dirs[c]
    visited.incl pos
  
  visited.len

proc solvePartTwo: int =
  var
    visited = [(0, 0)].toHashSet()
    santaPos, roboPos = (0, 0)
  
  for i, c in readFile "input.txt":
    if (i and 1) == 0:
      santaPos += dirs[c]
      visited.incl santaPos
    else:
      roboPos += dirs[c]
      visited.incl roboPos
  
  visited.len

echo solvePartOne()
echo solvePartTwo()