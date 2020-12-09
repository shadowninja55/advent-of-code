import deques, intsets, math, sequtils, strutils

proc twoSum(nums: Deque[int], target: int): bool =
    var seen = initIntSet()

    for num in nums:
        if (target - num) in seen:
            return true

        seen.incl num

proc solvePartOne(nums: seq[int]): int =
    var window = toDeque nums[0..24]

    for i in 25..nums.high:
        let target = nums[i]

        if not window.twoSum target:
            return target

        window.popFirst
        window.addLast target

proc solvePartTwo(nums: seq[int], target: int): int =
    for i in 0..nums.high:
        for j in i..nums.high:
            let window = nums[i..j]

            if window.sum == target:
                return window.min + window.max

let nums = toSeq(lines("input.txt")).map(parseInt)
echo solvePartOne nums
echo solvePartTwo(nums, solvePartOne nums)
