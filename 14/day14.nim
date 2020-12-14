import algorithm, intsets, math, npeg, sequtils, strutils, tables

proc solvePartOne: int =
    var
        mask: seq[char]
        mem: Table[int, int]

    let parser = peg("commands"):
        commands <- +command
        command <- (maskSet | memSet) * "\n"

        maskSet <- "mask = " * >36:
            mask = reversed $1
        memSet <- "mem[" * >+Digit * "] = " * >+Digit:
            var value = cast[set[0..35]](parseInt $2)

            for i, bit in mask:
                if bit == '0':
                    value.excl i
                elif bit == '1':
                    value.incl i

            mem[parseInt $1] = cast[int](value)

    assert parser.matchFile("input.txt").ok

    toSeq(mem.values).sum

proc solvePartTwo: int =
    var
        ones, spins: seq[int]
        mem: Table[int, int]

    let parser = peg("commands"):
        commands <- +command
        command <- (maskSet | memSet) * "\n"

        maskSet <- "mask = " * >36:
            reset ones
            reset spins

            for i, bit in reversed $1:
                if bit == '1':
                    ones.add i
                elif bit == 'X':
                    spins.add i

        memSet <- "mem[" * >+Digit * "] = " * >+Digit:
            var index = cast[set[0..35]](parseInt $1)

            for i in ones:
                index.incl i

            for num in 0..<(1 shl spins.len):
                let bits = num.toBin spins.len
                var child = index

                for i, bit in bits:
                    if bit == '0':
                        child.excl spins[i]
                    elif bit == '1':
                        child.incl spins[i]

                mem[cast[int](child)] = parseInt $2

    assert parser.matchFile("input.txt").ok

    toSeq(mem.values).sum

echo solvePartOne()
echo solvePartTwo()
