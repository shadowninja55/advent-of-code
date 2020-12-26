import strutils, sets, tables, sugar, sequtils, algorithm

proc processInput(): (Table[string, string], seq[string]) =
  var 
    possible: seq[(HashSet[string], HashSet[string])] # (names, codes)
    names: HashSet[string]

  # mapping out all possible fields
  for line in lines "input.txt":
    let 
      info = line.split " ("
      allergens = info[0].split " "
      label = info[1][9..^2].split ", "
    
    names = names + label.toHashSet
    possible.add (label.toHashSet, allergens.toHashSet)

  # filtering by intersection
  var intersected: Table[string, HashSet[string]] # (name, codes)

  for name in names:
    let codeSets = possible.filterIt(name in it[0]).mapIt(it[1])
    var shared = codeSets[0]

    for codeSet in codeSets:
      shared = shared * codeSet
  
    intersected[name] = shared
  
  # filtering by unique
  block unique:
    while true:
      for name, codes in intersected:
        if codes.len == 1:
          let code = codes.toSeq[0]

          for key in intersected.keys:
            if key != name:
              intersected[key].excl code
          
      block valid:
        for codes in intersected.values:
          if codes.len > 1:
            break valid
        
        break unique
  
  result[0] = collect initTable:
    for name, codes in intersected:
      {name: codes.toSeq[0]}
  
  result[1] = collect newSeq:
    for codes in possible.mapIt(it[1]):
      for code in codes:
        code

proc solvePartOne: int =
  let 
    (dict, codes) = processInput()
    valid = toSeq(dict.values).toHashSet

  for code in codes:
    if code notin valid:
      inc result

proc solvePartTwo: string =
  let 
    dict = processInput()[0]
    names = toSeq(dict.keys).sorted

    codes = collect newSeq:
      for name in names:
        dict[name]
  
  codes.join ","

echo solvePartOne()
echo solvePartTwo()