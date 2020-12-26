import strutils

proc solvePartOne: int =
  let content = readFile "input.txt"
  content.count('(') - content.count(')')

proc solvePartTwo: int =
  var floor = 0

  for i, c in readFile "input.txt":
    if c == '(':
      inc floor
    else:
      dec floor
    
    if floor == -1:
      return i + 1

echo solvePartOne()
echo solvePartTwo()