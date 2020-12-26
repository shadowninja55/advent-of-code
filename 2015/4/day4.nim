import md5, strutils

const input = "ckczppom"

proc crack(len: int): int =
  let pad = '0'.repeat len

  for i in 0..int.high:
    let 
      guess = input & $i
      hash = $(guess.toMD5())
    
    if hash[0..<len] == pad:
      return i

proc solvePartOne: int =
  crack 5

proc solvePartTwo: int =
  crack 6

echo solvePartOne()
echo solvePartTwo()