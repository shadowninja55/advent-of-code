import sequtils, strutils

func toCharSet[T](s: openarray[T]): set[char] =
    for c in s: result.incl(c)

func solvePartOne(groups: seq[string]): int =
    for group in groups:
        result += group.filter(isLowerAscii).toCharSet().len

func solvePartTwo(groups: seq[string]): int =
    for group in groups:
        var answered = {'a'..'z'}

        for person in group.splitLines():
            answered = answered * person.toCharSet()

        result += answered.len

const groups = slurp("input.txt").split("\n\n")
echo solvePartOne(groups)
echo solvePartTwo(groups)
