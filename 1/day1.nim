import strutils
import sets
import sequtils

proc solvePartOne(nums: seq[int], target: int): int =
    var seen = initHashSet[int]()

    for num in nums:
        if (target - num) in seen:
            return num * (target - num)
        
        seen.incl(num)

proc solvePartTwo(nums: seq[int], target: int): int =
    for i in nums:
        let j = solvePartOne(nums, target - i)

        if j > 0: 
            return i * j

let nums = toSeq(lines("input.txt")).map(parseInt)
echo solvePartOne(nums, 2020)
echo solvePartTwo(nums, 2020)
