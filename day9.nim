import intsets, sequtils, strutils

proc twoSum(nums: IntSet, target: int): bool =
    for num in nums:
        if (target - num) in nums:
            return true

proc solvePartOne(nums: seq[int]): int =
    var window = toIntSet nums[0..24]

    for i in 25..nums.high:
        let target = nums[i]

        if not window.twoSum target:
            return target

        window.excl nums[i - 25]
        window.incl nums[i]

proc solvePartTwo(nums: seq[int], target: int): int =
    var (sum, start) = (nums[0], 0)

    for i in 1..nums.high:
        while sum > target and start < i - 1:
            sum -= nums[start]
            inc start

        if sum == target:
            let window = nums[start..(i - 1)]
            return window.min + window.max

        sum += nums[i]

let nums = toSeq(lines("input.txt")).map(parseInt)

let target = solvePartOne nums
echo target
echo solvePartTwo(nums, target)
