import sequtils
import sets
import strutils
import re

func solvePartOne(groups: seq[string]): int =
    for group in groups:
        let matches = group.findAll(re"[a-z]")
        let answered = matches.mapIt(it[0]).toHashSet()
        result += answered.len

func solvePartTwo(groups: seq[string]): int =
    for group in groups:
        var answered = toSeq('a'..'z').toHashSet()

        for person in group.splitLines():
            answered = answered * person.toHashSet()
        
        result += answered.len

let groups = readFile("input.txt").split("\n\n")
echo solvePartOne(groups)
echo solvePartTwo(groups)
