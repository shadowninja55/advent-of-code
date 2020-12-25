import sets, sequtils, strutils, algorithm, sugar, tables, math

type 
  Piece = seq[seq[char]]
  Puzzle = object
    edges: Table[int, HashSet[seq[char]]]
    pieces: Table[int, Piece]

proc loadPuzzle(): Puzzle =
  proc getEdges(piece: Piece): HashSet[seq[char]] =
    for edge in [piece[0], piece[^1], piece.mapIt(it[0]), piece.mapIt(it[^1])]:
      result.incl edge
      result.incl edge.reversed

  for rawPiece in readFile("input.txt").split("\n\n"):
    let 
      rawLines = rawPiece.splitLines()
      id = rawLines[0][5..^2].parseInt()
      piece = rawLines[1..^1].mapIt(it.toSeq())
    
    result.pieces[id] = piece
    result.edges[id] = piece.getEdges()

proc getCorners(puzzle: Puzzle): seq[int] =
  for id, edges in puzzle.edges:
    var matches = 0

    for edge in edges:
      for subId, subEdges in puzzle.edges:
        if subId != id:
          if edge in subEdges:
            inc matches

    if matches == 4:
      result.add id

proc solvePartOne: int =
  prod loadPuzzle().getCorners

proc solvePartTwo: seq[int] =
  ## this function simply provides some estimates
  let sampleFilled = readFile("sample.txt").count('#') + readFile("sample.txt").count('O')
  var inputFilled = 0

  for piece in loadPuzzle().pieces.values:
    let shrunk = piece[1..^2].mapIt(it[1..^2])
    for row in shrunk:
      inputFilled += row.count('#')
  
  let estimate = ((2.float * inputFilled.float) / sampleFilled.float).int
  
  for monsters in (estimate - 2)..(estimate + 2):
    result.add(inputFilled - (monsters * 15))

echo solvePartOne()
echo solvePartTwo()