import sets, strutils, sugar

proc solvePartOne: int =
  type Pos3 = tuple[x, y, z: int]

  # parsing
  let raw = readFile("input.txt").splitLines

  var cubes = collect initHashSet:
    for y in 0..raw.high:
      for x in 0..raw[0].high:
        if raw[y][x] == '#':
          {(x, y, 0)}

  # active near function
  proc activeNear(pos: Pos3): int =
    for x in -1..1:
      for y in -1..1:
        for z in -1..1:
          if likely (x, y, z) != (0, 0, 0):
            let cube = (pos.x + x, pos.y + y, pos.z + z)

            if cube in cubes:
              inc result

  # steps loop
  for _ in 1..6:
    var nextCubes = cubes

    for x in -6..13:
      for y in -6..13:
        for z in -6..6:
          let cube = (x, y, z)

          if cube in cubes:
            if cube.activeNear notin 2..3:
              nextCubes.excl cube
          else:
            if cube.activeNear == 3:
              nextCubes.incl cube

    cubes = nextCubes

  cubes.len

proc solvePartTwo: int =
  type Pos4 = tuple[x, y, z, w: int]

  # parsing
  let raw = readFile("input.txt").splitLines

  var cubes = collect initHashSet:
    for y in 0..raw.high:
      for x in 0..raw[0].high:
        if raw[y][x] == '#':
          {(x, y, 0, 0)}

  # active near function
  proc activeNear(pos: Pos4): int =
    for x in -1..1:
      for y in -1..1:
        for z in -1..1:
          for w in -1..1:
            if likely (x, y, z, w) != (0, 0, 0, 0):
              let cube = (pos.x + x, pos.y + y, pos.z + z, pos.w + w)

              if cube in cubes:
                inc result

  # steps loop
  for _ in 1..6:
    var nextCubes = cubes

    for x in -6..13:
      for y in -6..13:
        for z in -6..6:
          for w in -6..6:
            let cube = (x, y, z, w)

            if cube in cubes:
              if cube.activeNear notin 2..3:
                nextCubes.excl cube
            else:
              if cube.activeNear == 3:
                nextCubes.incl cube

    cubes = nextCubes

  cubes.len

echo solvePartOne()
echo solvePartTwo()
