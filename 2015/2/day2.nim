import strscans, math, sequtils

proc solvePartOne: int =
  for line in lines "input.txt":
    let 
      (ok, l, w, h) = line.scanTuple "$ix$ix$i"
      surface = 2 * l * w + 2 * w * h + 2 * h * l
      slack = [l, w, h].prod div [l, w, h].max
    
    result += surface + slack

proc solvePartTwo: int =
  for line in lines "input.txt":
    let
      (ok, l, w, h) = line.scanTuple "$ix$ix$ix"
      ribbon = [l, w, h].mapIt(it * 2).sum() - ([l, w, h].max * 2)
      bow = [l, w, h].prod
    
    result += ribbon + bow

echo solvePartOne()
echo solvePartTwo()