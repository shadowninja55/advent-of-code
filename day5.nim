import sequtils
import math

func getSeatPos(pass: string): (int, int) =
    let row = block:
        var (lower, upper) = (0, 127)

        for i in 0..6:
            if pass[i] == 'F':
                upper -= ceil((upper - lower) / 2).int
            else:
                lower += ceil((upper - lower) / 2).int
        
        lower
    
    let col = block:
        var (lower, upper) = (0, 7)

        for i in 7..9:
            if pass[i] == 'L':
                upper -= ceil((upper - lower) / 2).int
            else:
                lower += ceil((upper - lower) / 2).int
        
        lower

    (row, col)

func solvePartOne(passes: seq[string]): int =
    for pass in passes:
        let (row, col) = pass.getSeatPos()
        result = max(result, row * 8 + col)
    
func solvePartTwo(passes: seq[string]): int =
    var seats: array[128, array[8, int]]

    for pass in passes:
        let (row, col) = pass.getSeatPos()
        seats[row][col] = row * 8 + col
    
    var valid = false

    for y, row in seats:
        for x, seat in row:
            if valid and seat == 0:
                return y * 8 + x

            if seat != 0:
                valid = true

let passes = toSeq(lines("input.txt"))
echo solvePartOne(passes)
echo solvePartTwo(passes)