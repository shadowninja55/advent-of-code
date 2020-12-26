import strutils, re, sequtils

func hasThreeVowels(str: string): bool =
  const vowels = {'a', 'e', 'i', 'o', 'u'}
  str.filterIt(it in vowels).len >= 3

proc solvePartOne: int =
  for line in lines "input.txt":
    if line.hasThreeVowels() and line.findAll(re"(\w)\1").len > 0:
      if ["ab", "cd", "pq", "xy"].mapIt(it notin line) == true.repeat 4:
        inc result

proc solvePartTwo: int =
  for line in lines "input.txt":
    if line.contains(re"(\w)(\w).*\1\2") and line.contains(re"(\w).\1"):
      inc result

echo solvePartOne()
echo solvePartTwo()