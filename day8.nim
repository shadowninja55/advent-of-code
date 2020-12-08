import sequtils
import strutils
import intsets
import tables

func interpret(instructions: seq[string]): (int, bool) =
    var cursor = 0
    var executed = initIntSet()

    while cursor <= instructions.high:
        if cursor in executed:
            result[1] = true
            break
        else:
            executed.incl(cursor)

        let line = instructions[cursor]
        let (cmd, num) = (line[0..2], parseInt(line[4..^1]))

        case cmd:
            of "acc":
                result[0] += num
            of "jmp":
                cursor += num
                continue
            of "nop":
                discard
            else:
                discard
        
        inc cursor

func solvePartOne(instructions: seq[string]): int =
    interpret(instructions)[0]

func solvePartTwo(instructions: seq[string]): int =
    const cmdSwap = {"acc": "", "nop": "jmp", "jmp": "nop"}.toTable()

    for cursor, line in instructions:
        var (cmd, num) = (line[0..2], line[4..^1])
        cmd = cmdSwap[cmd]

        if cmd == "":
            continue
        
        var edited = instructions
        edited[cursor] = cmd & num

        let (acc, err) = interpret(edited)
        if not err:
            return acc

let instructions = toSeq(lines("input.txt"))
echo solvePartOne(instructions)
echo solvePartTwo(instructions)
