import algorithm, intsets, sequtils, strutils, tables

proc solvePartOne(adapters: seq[int]): int =
    var
        nums = {1: 0, 3: 0}.toTable
        last = adapters[0]

    for adapter in adapters[1..^1]:
        let diff = adapter - last
        inc nums[diff]
        last = adapter

    nums[1] * nums[3]

proc solvePartTwo(adapters: seq[int]): int =
    var poss = {0: 1}.toTable

    for adapter in adapters[1..^1]:
        for i in 1..3:
            let diff = adapter - i

            if diff in poss:
                poss.mgetOrPut(adapter, 0) += poss[diff]

    poss[adapters.max]

var adapters = toSeq(lines("input.txt")).map(parseInt)
adapters &= @[0, adapters.max + 3]
adapters.sort

echo solvePartOne adapters
echo solvePartTwo adapters
