const 
  card = 14205034
  door = 18047856

func solvePartOne: int =
  var value = 1
  result = 1

  for loops in 1..int.high:
    value = value * 7 mod 20201227
    result = result * card mod 20201227

    if value == door:
      return

func solvePartTwo: string =
  "go finish the rest of your puzzles, you've got this!"

echo solvePartOne()
echo solvePartTwo()