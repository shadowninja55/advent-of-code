import sequtils, strutils

proc solvePartOne(nums: seq[int], target = 2020): int =
    var seen: set[-2020..2020]

    for num in nums:
        if (target - num) in seen:
            return num * (target - num)

        seen.incl(num)

proc solvePartTwo(nums: seq[int], target = 2020): int =
    for i in nums:
        let j = solvePartOne(nums, target - i)

        if j > 0:
            return i * j

let nums = toSeq(lines("input.txt")).map(parseInt)
echo solvePartOne nums
echo solvePartTwo nums