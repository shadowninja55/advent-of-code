import sequtils

func locate(bounds: Slice[int], pass: string, letter: char): int =
    result = bounds.a
    var upper = bounds.b

    for c in pass:
        let mid = (upper - result) div 2
        if c == letter:
            upper -= mid
        else:
            result += mid

func solvePartOne(passes: seq[string]): int =
    for pass in passes:
        let row = locate(0..128, pass[0..6], 'F')
        let col = locate(0..8, pass[7..9], 'L')
        result = max(result, row * 8 + col)

func solvePartTwo(passes: seq[string]): int =
    var seats: array[128, array[8, int]]

    for pass in passes:
        let row = locate(0..128, pass[0..6], 'F')
        let col = locate(0..8, pass[7..9], 'L')
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
