import sequtils, sugar

# BOTH PARTS
type Pos = tuple[y, x: int]
type Grid = seq[string]

const deltas: array[8, Pos] = [
    (0, 1), (1, 0), (0, -1), (-1, 0),
    (1, 1), (-1, -1), (1, -1), (-1, 1)
]

# PART ONE
iterator neighbours(grid: Grid, pos: Pos): char =
    for delta in deltas:
        let (y, x) = (pos.y + delta.y, pos.x + delta.x)

        if y in 0..grid.high and x in 0..grid[0].high:
            yield grid[y][x]

proc emptyAdjacent(grid: Grid, pos: Pos): bool =
    for seat in grid.neighbours pos:
        if seat == '#':
            return false

    true

proc overFourOccupied(grid: Grid, pos: Pos): bool =
    var occupied = 0

    for seat in grid.neighbours pos:
        if seat == '#':
            inc occupied

    occupied >= 4

# BOTH PARTS
proc countSeats(grid: Grid, seatingCond, exitCond: (Grid, Pos) -> bool): int =
    var grid = grid

    while true:
        var prev = grid
        var seatings, exits: seq[Pos]

        for y, row in grid:
            for x, seat in row:
                case seat
                of 'L':
                    if grid.seatingCond (y, x):
                        seatings.add (y, x)
                of '#':
                    if grid.exitCond (y, x):
                        exits.add (y, x)
                else:
                    discard

        for pos in seatings:
            grid[pos.y][pos.x] = '#'

        for pos in exits:
            grid[pos.y][pos.x] = 'L'

        if grid == prev:
            break

    for y in 0..grid.high:
        for x in 0..grid[0].high:
            if grid[y][x] == '#':
                inc result

# PART ONE
proc solvePartOne(grid: Grid): int =
    grid.countSeats(emptyAdjacent, overFourOccupied)

# PART TWO
iterator visible(grid: Grid, pos: Pos): char =
    for delta in deltas:
        var steps = 1

        while true:
            let (y, x) = (pos.y + (delta.y * steps), pos.x + (delta.x * steps))

            if y notin 0..grid.high or x notin 0..grid[0].high:
                break

            if grid[y][x] != '.':
                yield grid[y][x]
                break

            inc steps

proc emptyVisible(grid: Grid, pos: Pos): bool =
    for seat in grid.visible pos:
        if seat == '#':
            return false

    true

proc overFiveVisible(grid: Grid, pos: Pos): bool =
    var visible = 0

    for seat in grid.visible pos:
        if seat == '#':
            inc visible

    visible >= 5

proc solvePartTwo(grid: Grid): int =
    grid.countSeats(emptyVisible, overFiveVisible)

let grid = toSeq(lines("input.txt"))
echo solvePartOne grid
echo solvePartTwo grid
