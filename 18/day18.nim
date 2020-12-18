import macros, math, strutils

proc `>+<`(a, b: uint64): uint64 =
  a + b

proc `>*<`(a, b: uint64): uint64 =
  a * b

macro solvePartOne(input: static[string]): uint64 =
  parseExpr(input.multiReplace(("+", ">+<"), ("*", ">*<")))

macro solvePartTwo(input: static[string]): uint64 = 
  parseExpr(input.replace("*", ">*<"))

const input = "sum [" & slurp("input.txt").replace("\n", ",") & "]"
echo solvePartOne input
echo solvePartTwo input