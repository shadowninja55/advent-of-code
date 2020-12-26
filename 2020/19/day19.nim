import re, strutils, sugar, tables

type RuleMap = Table[int, string]

# making rule map
proc makeRules(input: string): RuleMap =
  collect initTable:
    for line in input.replace("\"", "").splitLines:
      if line =~ re"(\d+)\:(.+)":
        {matches[0].parseInt: matches[1].strip}

# recursion
proc isNum(s: string): bool =
  try:
    discard s.parseInt
    return true
  except ValueError: discard

proc recurse(rules: RuleMap, n: int): string =
  var res = collect newSeq:
    for rule in rules[n].split('|'):
      var parsed = ""

      for c in rule.split(' '):
        if c.isNum:
          parsed &= rules.recurse c.parseInt
        else:
          parsed &= c
      
      parsed
  
  result = res.join "|"

  if '|' in result:
    return "(?:" & result & ")"

# solving
proc solve(input: string, rules: RuleMap): int =
  for line in input.findAll(re"[a|b]+\n"):
    if line =~ rex(rules.recurse(0) & "\n$"):
      inc result

# solving part one
proc solvePartOne: int =
  let
    input = readFile "input.txt"
    rules = makeRules input

  input.solve rules

# solving part two
proc solvePartTwo: int =
  let input = readFile "input.txt"
  var rules = makeRules input

  rules[31] = rules.recurse 31
  rules[42] = rules.recurse 42
  rules[8] = rules[42] & "+"
  
  var res = collect newSeq:
    for n in 1..5:
      rules[42] & "{" & $n & "}" & rules[31] & "{" & $n & "}"

  rules[11] = "(?:" & res.join("|") & ")"

  input.solve rules

# wrapping up
echo solvePartOne()
echo solvePartTwo()