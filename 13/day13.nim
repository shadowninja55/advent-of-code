import sequtils, std/enumerate, strutils, sugar, tables

proc solvePartOne(): int =
    let file = open("input.txt", fmRead)
    defer: file.close

    var estimate = parseInt file.readLine

    var buses = collect newSeq:
        for bus in file.readLine.split ',':
            if bus != "x":
                parseInt bus

    var departure = estimate

    while true:
        for bus in buses:
            if departure mod bus == 0:
                return (departure - estimate) * bus

        inc departure

proc solvePartTwo(): int =
    let file = open("input.txt", fmRead)
    defer: file.close()
    discard file.readLine

    var buses: seq[int]

    for bus in file.readLine.split ',':
        if bus == "x":
            buses.add 1
        else:
            buses.add bus.parseInt

    var departure = 1

    while true:
        var skip = 1

        block valid:
            for diff in 0..buses.high:
                if (departure + diff) mod buses[diff] != 0:
                    break valid

                skip *= buses[diff]

            return departure

        departure += skip

echo solvePartOne()
echo solvePartTwo()
