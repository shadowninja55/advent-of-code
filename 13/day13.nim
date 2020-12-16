import sequtils, std/enumerate, strutils, sugar, tables

proc solvePartOne(): int =
    let 
        file = open("input.txt", fmRead)
        start = parseInt file.readLine

    defer: file.close

    var buses = collect newSeq:
        for bus in file.readLine.split ',':
            if bus != "x":
                bus.parseInt

    var lowestWait = int.high
    var lowestBus = 0

    for bus in buses:
        let wait = bus - (start mod bus)

        if wait < lowestWait:
            lowestWait = wait
            lowestBus = bus
    
    lowestWait * lowestBus

proc solvePartTwo(): int =
    let file = open("input.txt", fmRead)
    defer: file.close
    discard file.readLine

    var buses = newSeq[int]()

    for bus in file.readLine.split ',':
        if bus == "x":
            buses.add 1
        else:
            buses.add bus.parseInt

    var departure = 1

    while true:
        var skip = 1

        block valid:
            for diff, bus in buses:
                if (departure + diff) mod bus != 0:
                    break valid

                skip *= bus

            return departure

        departure += skip

echo solvePartOne()
echo solvePartTwo()
