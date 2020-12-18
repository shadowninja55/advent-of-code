import macros, strutils, os, osproc

const code = """
proc `>+<`(a, b: uint64): uint64 =
  a + b

proc `>*<`(a, b: uint64): uint64 =
  a * b

var result: uint64 = 0

"""

proc process(replacements: varargs[(string, string)]): uint64 =
  # writing to file
  var file = open("eval.nim", fmWrite)
  file.write code

  for line in lines "input.txt":
    var replaced = line

    for replacement in replacements:
      replaced = replaced.replace(replacement[0], replacement[1])

    let fixed = "result += " & replaced & "\n"
    file.write fixed
  
  file.write "\necho result"
  file.close

  # compiling
  discard execShellCmd "nim c eval.nim > nul"
  result = parseUInt(execProcess("eval").strip)
  
  # cleaning up
  removeFile "eval.nim"
  removeFile "eval.exe"

proc solvePartOne: uint64 =
  process(("+", ">+<"), ("*", ">*<"))

proc solvePartTwo: uint64 = 
  process(("*", ">*<"))

echo solvePartOne()
echo solvePartTwo()