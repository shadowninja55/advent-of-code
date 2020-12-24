import algorithm, sequtils, strutils, tables

proc solvePartOne(adapters: seq[int]): int =
    var
        nums = initCountTable[int]()
        last = adapters[0]

    for adapter in adapters[1..^1]:
        nums.inc adapter - last
        last = adapter

    nums[1] * nums[3]

proc solvePartTwo(adapters: seq[int]): int =
    var poss = [0].toCountTable

    for adapter in adapters[1..^1]:
        for i in 1..3:
            poss.inc(adapter, poss[adapter - i])

    poss[adapters.max]

var adapters = toSeq(lines("input.txt")).map parseInt
adapters &= @[0, adapters.max + 3]
adapters.sort

echo solvePartOne adapters
echo solvePartTwo adapters