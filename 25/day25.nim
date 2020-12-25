const 
  card = 14205034
  door = 18047856

func calcLoops(key: int): int =
  var value = 1
  
  for loops in 1..int.high:
    value = (value * 7) mod 20201227

    if value == key:
      return loops

func solvePartOne: int =
  result = 1

  for _ in 1..door.calcLoops():
    result = (result * card) mod 20201227

func solvePartTwo: string =
  "go finish the rest of your puzzles, you've got this!"

echo solvePartOne()
echo solvePartTwo()