import sets, npeg, tables

# helpers
type Tile = tuple[x, y: int]

proc `+`(a: Tile, b: (int, int)): Tile =
  (a.x + b[0], a.y + b[1])

proc `+=`(a: var Tile, b: (int, int)) =
  a = (a.x + b[0], a.y + b[1]).Tile

const directions = {
  "ne": (1, 1), "nw": (-1, 1),
  "se": (1, -1), "sw": (-1, -1),
  "e": (2, 0), "w": (-2, 0)
}.toTable()

proc flipTiles(): HashSet[Tile] =
  var tile = (0, 0).Tile

  let parser = peg("lines", tiles: HashSet[Tile]):
    lines <- +line
    line <- +direction * "\n":
      if tile notin tiles:
        tiles.incl tile
      else:
        tiles.excl tile

      reset tile
    direction <- "ne" | "nw" | "se" | "sw" | "e" | "w":
      tile += directions[$0]

  doAssert parser.matchFile("input.txt", result).ok

# part one
proc solvePartOne: int =
  flipTiles().len

# part two
proc solvePartTwo: int =
  var tiles = flipTiles()

  proc adjacent(tile: Tile): int =
    for direction in directions.values:
      if (tile + direction) in tiles:
        inc result

  for _ in 1..100:
    var next = tiles

    for x in -125..125:
      for y in -125..125:
        let tile = (x, y).Tile

        # tile is black
        if tile in tiles:
          if tile.adjacent in {0, 3..6}:
            next.excl tile
        else: # tile is white
          if tile.adjacent == 2:
            next.incl tile
    
    tiles = next

  tiles.len

echo solvePartOne()
echo solvePartTwo()
