import npeg
import std/strutils
import std/tables

let bag = {"red": 12, "green": 13, "blue": 14}.toTable
var 
  possible = true
  partOne = 0
  partTwo = 0

let parser = peg("game", maxes: Table[string, int]):
  game <- "Game " * >+Digit * ": " * record:
    if possible:
      partOne += parseInt($1)
    possible = true
    partTwo += maxes["red"] * maxes["green"] * maxes["blue"]
  record <- subset * *("; " * subset)
  subset <- cubes * *(", " * cubes)
  cubes <- >+Digit * " " * >+Lower:
    let count = parseInt($1)
    if count > bag[$2]:
      possible = false
    maxes[$2] = max(maxes[$2], count)

for line in lines("input.txt"):
  var maxes = {"red": 0, "green": 0, "blue": 0}.toTable
  assert parser.match(line, maxes).ok

echo partOne
echo partTwo
