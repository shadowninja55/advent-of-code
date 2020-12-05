import strutils
import re
import sets
import sequtils
import tables
import strscans
import sugar

const entries = staticRead("input.txt").split("\n\n")
const requiredKeys = toHashSet(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])

proc solvePartOne(): int =
    for entry in entries:
        let keys = entry.findAll(re"[a-z]{3}:").mapIt(it[0..^2]).toHashSet()

        if keys == requiredKeys or (keys.len == 7 and "cid" notin keys):
            inc result

proc solvePartTwo(): int =
    for entry in entries: 
        let fields = collect newTable:
            for rawField in entry.findAll(re"[a-z]{3}:[\w#]+"):
                let field = rawField.split(":")
                {field[0]: field[1]}
        
        if (toSeq(fields.keys()).toHashSet() == requiredKeys) or (fields.len == 7 and "cid" notin fields):
            block validField:
                for key, value in fields:
                    case key:
                        of "byr":
                            if parseInt(value) notin 1920..2002: 
                                break validField
                        of "iyr":
                            if parseInt(value) notin 2010..2020:
                                break validField
                        of "eyr":
                            if parseInt(value) notin 2020..2030:
                                break validField
                        of "hgt":
                            var
                                amount: int
                                unit: string

                            if value.scanf("$i$*", amount, unit):
                                if unit == "cm":
                                    if amount notin 150..193:
                                        break validField
                                elif unit == "in":
                                    if amount notin 59..76:
                                        break validField
                                else:
                                    break validField
                            else:
                                break validField
                        of "hcl":
                            if not value.match(re"#[\da-f]{6}$"):
                                break validField
                        of "ecl":
                            const validEyeColors = toHashSet(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
                            
                            if value notin validEyeColors:
                                break validField
                        of "pid":
                            if not value.match(re"\d{9}$"):
                                break validField
                        else:
                            discard
                
                inc result

echo solvePartOne()
echo solvePartTwo()
