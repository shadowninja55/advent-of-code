import tables, sugar

proc solvePartOne(target = 2020): int =
    const input = [18, 11, 9, 0, 5, 1]

    var last, turn: int

    # storing initial numbers in memory
    var seen = collect initTable:
        for num in input:
            last = num
            inc turn
            {num: turn - 1}

    # calculating next numbers
    while true:
        if turn == target:
            return last

        if last notin seen:
            seen[last] = turn - 1
            last = 0
        else:
            let diff = turn - 1 - seen[last]
            seen[last] = turn - 1
            last = diff

        inc turn

proc solvePartTwo: int =
    solvePartOne 30000000

echo solvePartOne()
echo solvePartTwo()