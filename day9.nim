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
    var (sum, start) = (nums[0], 0)

    for i in 1..nums.len:
        while sum > target and start < i - 1:
            sum -= nums[start]
            inc start

        if sum == target:
            let window = nums[start..(i - 1)]
            return window.min + window.max

        if i < nums.len:
            sum += nums[i]

let nums = toSeq(lines("input.txt")).map(parseInt)
echo solvePartOne nums
echo solvePartTwo(nums, solvePartOne nums)
