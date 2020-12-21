import npeg, sets, sequtils, strutils, algorithm, sugar, tables, math

type Piece = seq[string]

type Puzzle = object
  edges: Table[int, HashSet[string]]
  pieces: Table[int, Piece]

proc loadPuzzle(): Puzzle =
  proc edges(piece: Piece): HashSet[string] =
    # top and bottom
    for y in [0, piece.high]:
      result.incl piece[y]
      result.incl piece[y].reversed.join("")
    
    # sides
    for x in [0, piece[0].high]:
      var edge = ""

      for y in 0..piece.high:
        edge.add piece[y][x]
      
      result.incl edge
      result.incl edge.reversed.join("")

  var id: int

  let parser = peg("lines", puzzle: Puzzle):
    lines <- +(id * "\n" * tile * "\n")

    id <- "Tile " * >+Digit * ":":
      id = parseInt $1
    
    tile <- ({'.', '#'}[10] * "\n")[10]:
      let piece = ($0).split('\n')[0..^2]
      puzzle.edges[id] = piece.edges
      puzzle.pieces[id] = piece

  assert parser.matchFile("input.txt", result).ok

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

proc solvePartTwo: int =
  # INCOMPLETE
  discard

echo solvePartOne()